CREATE OR REPLACE TRIGGER CheckCapacityAfterTransaction
FOR INSERT OR UPDATE ON transaction
COMPOUND TRIGGER

    -- Type to store rowids and train_ids of transactions being processed
    TYPE t_transactions_info IS TABLE OF ROWID INDEX BY PLS_INTEGER;
    v_transactions_info t_transactions_info;
    
    -- After Each Row Section: Store necessary row identifiers
    AFTER EACH ROW IS
    BEGIN
        v_transactions_info(v_transactions_info.COUNT + 1) := :NEW.ROWID;
    END AFTER EACH ROW;

    -- After Statement Section: Process all stored transactions
    AFTER STATEMENT IS
        v_current_passenger_count NUMBER;
        v_train_capacity NUMBER;
        v_exists NUMBER;
        v_rowid ROWID;
    BEGIN
        FOR i IN 1 .. v_transactions_info.COUNT LOOP
            v_rowid := v_transactions_info(i);
            
            SELECT SUM(passenger_count) INTO v_current_passenger_count
            FROM transaction
            WHERE train_train_id = (SELECT train_train_id FROM transaction WHERE ROWID = v_rowid)
            AND offboard_station_id IS NULL;

            SELECT train_capacity INTO v_train_capacity
            FROM train
            WHERE train_id = (SELECT train_train_id FROM transaction WHERE ROWID = v_rowid);

            SELECT COUNT(*) INTO v_exists
            FROM PEAK_HOURS
            WHERE train_train_id = (SELECT train_train_id FROM transaction WHERE ROWID = v_rowid);

            IF v_current_passenger_count > v_train_capacity AND v_exists = 0 THEN
                INSERT INTO PEAK_HOURS (train_train_id, peak_hours_id)
                VALUES ((SELECT train_train_id FROM transaction WHERE ROWID = v_rowid), peak_hours_peak_hours_id_seq.NEXTVAL);
            END IF;
        END LOOP;
    END AFTER STATEMENT;

END CheckCapacityAfterTransaction;
