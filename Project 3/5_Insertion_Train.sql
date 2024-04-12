set serveroutput on
CREATE OR REPLACE 
    PROCEDURE The_Line.add_train(
        source_station in VARCHAR,
        target_station_id in VARCHAR,
        train_capacity in INTEGER) 
    IS 
BEGIN
    BEGIN
        FOR current_train IN 1..20
        LOOP
            DBMS_OUTPUT.PUT_LINE('Inserting Data [Train]: ' || current_train);
            INSERT INTO
                TRAIN(TRAIN_ID, SOURCE_STATION_ID, TARGET_STATION_ID, TRAIN_CAPACITY)
                VALUES ( 'T0' || current_train, source_station, target_station_id, train_capacity);
            COMMIT;
        END LOOP;  
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data Already Exists.');
END;
/
EXEC add_train('S001', 'S010', 0);
