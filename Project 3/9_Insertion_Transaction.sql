set serveroutput on
CREATE OR REPLACE 
    PROCEDURE The_Line.add_transaction(
        TRANSACTION_ID in VARCHAR,
        ONBOARD_STATION_ID in VARCHAR,
        OFFBOARD_STATION_ID in VARCHAR,
        PASSENGER_COUNT in NUMBER,
        TRAIN_TRAIN_ID in VARCHAR,
        PASSENGER_PASSENGER_ID in VARCHAR) 
    IS 
BEGIN
    INSERT INTO
        TRANSACTION ( TRANSACTION_ID, ONBOARD_STATION_ID, OFFBOARD_STATION_ID, PASSENGER_COUNT, TRAIN_TRAIN_ID, PASSENGER_PASSENGER_ID)
        VALUES ( TRANSACTION_ID, ONBOARD_STATION_ID, OFFBOARD_STATION_ID, PASSENGER_COUNT, TRAIN_TRAIN_ID, PASSENGER_PASSENGER_ID);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data Already Exists.');
END;
/


EXEC add_transaction( transaction_transaction_id_seq.nextval, 'S001', 'S011',  1, 'T01', 'P001');
EXEC add_transaction( transaction_transaction_id_seq.nextval, 'S002', 'S006',  1, 'T01', 'P002');
EXEC add_transaction( transaction_transaction_id_seq.nextval, 'S003', 'S011',  1, 'T01', 'P003');
EXEC add_transaction( transaction_transaction_id_seq.nextval, 'S004', 'S011',  1, 'T01', 'P004');
EXEC add_transaction( transaction_transaction_id_seq.nextval, 'S005', 'S011',  1, 'T01', 'P005');
EXEC add_transaction( transaction_transaction_id_seq.nextval, 'S006', 'S011',  1, 'T01', 'P006');

