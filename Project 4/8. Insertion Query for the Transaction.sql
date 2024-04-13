-- BELOW ARE THE QUERIES TO START THE TRASNACTION ...
set serveroutput on
CREATE OR REPLACE 
    PROCEDURE create_transaction(
        required_PASSENGER_ID in VARCHAR,
        REQUIRED_STATION in VARCHAR,
        PASSENGER_COUNT in NUMBER,
        REQUIRED_TIME in TIMESTAMP
        ) 
    IS
    TRAIN_TRAIN_ID VARCHAR(20); 
    IS_AVAILABLE INTEGER := 0;
    IS_TRAIN_AVAILABLE INTEGER := 0;
BEGIN
    SELECT count(*)
        INTO IS_TRAIN_AVAILABLE
        FROM station_book 
        where station_id = REQUIRED_STATION and arrival_time > REQUIRED_TIME;
    
    IF IS_TRAIN_AVAILABLE = 0 THEN
        DBMS_OUTPUT.PUT_LINE('SORRY NO TRAIN AVAILABLE. COME NEXT DAY!');
    ELSE
        SELECT TRAIN_ID 
            INTO TRAIN_TRAIN_ID 
            FROM station_book 
            where 
                station_id = REQUIRED_STATION and 
                arrival_time > REQUIRED_TIME
            order by arrival_time
            FETCH FIRST 1 ROW ONLY;
        DBMS_OUTPUT.PUT_LINE('Selected Train' || TRAIN_TRAIN_ID);

        SELECT COUNT(*) INTO IS_AVAILABLE
            FROM TRANSACTION
            WHERE 
                PASSENGER_PASSENGER_ID = required_PASSENGER_ID AND
                OFFBOARD_STATION_ID IS NULL;
    
        IF IS_AVAILABLE = 0 THEN
            INSERT INTO
                TRANSACTION ( TRANSACTION_ID, ONBOARD_STATION_ID, OFFBOARD_STATION_ID, PASSENGER_COUNT, TRAIN_TRAIN_ID, PASSENGER_PASSENGER_ID)
                VALUES ( 
                    transaction_transaction_id_seq.nextval, 
                    REQUIRED_STATION, 
                    NULL, 
                    PASSENGER_COUNT, 
                    TRAIN_TRAIN_ID, 
                    required_PASSENGER_ID
                );
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('SORRY! TRANSACTION CANNOT BE INITIATED.');
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG: ' || SQLERRM);
END;
/

EXEC create_transaction( 'P016', 'S003', 5, TO_TIMESTAMP('20-MAR-24 09:10:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM'));
EXEC create_transaction( 'P006', 'S003', 5, TO_TIMESTAMP('20-MAR-24 10:10:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM'));
EXEC create_transaction( 'P001', 'S003', 5, TO_TIMESTAMP('20-MAR-24 09:40:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM'));
EXEC create_transaction( 'P002', 'S004', 5, TO_TIMESTAMP('20-MAR-24 11:10:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM'));
EXEC create_transaction( 'P007', 'S005', 5, TO_TIMESTAMP('20-MAR-24 11:10:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM'));
EXEC create_transaction( 'P008', 'S004', 5, TO_TIMESTAMP('20-MAR-24 04:10:00.00 PM', 'DD-MON-RR HH:MI:SS.FF PM'));
EXEC create_transaction( 'P010', 'S002', 5, TO_TIMESTAMP('21-MAR-24 09:10:00.00 PM', 'DD-MON-RR HH:MI:SS.FF AM'));





-- BELOW ARE THE QUERIES TO CLOSE THE TRANSACTION ...
set serveroutput on
CREATE OR REPLACE 
    PROCEDURE close_transaction(
        REQUIRED_PASSENGER in VARCHAR,
        REQUIRED_STATION in VARCHAR) 
    IS
    TRAIN_TRAIN_ID VARCHAR(20);
    IS_AVAILABLE INTEGER := 0;
BEGIN
    SELECT COUNT(*) INTO IS_AVAILABLE
        FROM TRANSACTION
        WHERE 
            PASSENGER_PASSENGER_ID = PASSENGER_PASSENGER_ID AND
            OFFBOARD_STATION_ID IS NOT NULL;
            
    IF IS_AVAILABLE = 0 THEN
        UPDATE TRANSACTION
            SET OFFBOARD_STATION_ID = REQUIRED_STATION
            WHERE PASSENGER_PASSENGER_ID = REQUIRED_PASSENGER; 
    ELSE
        DBMS_OUTPUT.PUT_LINE('SORRY! REQUEST CANNOT BE PROCESSED!');
    END IF;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG! : ' || SQLERRM);
END;
/

EXEC close_transaction( 'P016', 'S010');


-- View to get the current head count of each train ...
CREATE OR REPLACE VIEW current_passenger_count AS
SELECT 
    t.train_train_id,
    SUM(t.passenger_count) AS current_passenger_count
FROM 
    transaction t
WHERE 
    t.offboard_station_id IS NULL
GROUP BY 
    t.train_train_id;

select * from current_passenger_count;


