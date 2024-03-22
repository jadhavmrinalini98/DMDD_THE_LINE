set serveroutput on
CREATE OR REPLACE 
    PROCEDURE The_Line.add_station(
        STATION_ID in VARCHAR,
        STATION_NAME in VARCHAR,
        ARRIVAL_TIME in TIMESTAMP,
        TRAIN_TRAIN_ID in VARCHAR) 
    IS 
BEGIN
    INSERT INTO
        STATION ( STATION_ID, STATION_NAME, ARRIVAL_TIME, TRAIN_TRAIN_ID)
        VALUES ( STATION_ID, STATION_NAME, ARRIVAL_TIME, TRAIN_TRAIN_ID);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data Already Exists.');
END;
/


EXEC add_station('S001', 'Boston Collage', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T01');
EXEC add_station('S002', 'Washington St', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T02');
EXEC add_station('S003', 'Warren St' , TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T03');
EXEC add_station('S004', 'Babcock St', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T04');
EXEC add_station('S005', 'Amory St', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T05');
EXEC add_station('S006', 'Boston Central', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T06');
EXEC add_station('S007', 'Boston East', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T07');
EXEC add_station('S008', 'Kenmore', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T08');
EXEC add_station('S009', 'Hymn', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T09');
EXEC add_station('S010', 'Arlington', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T010');
EXEC add_station('S011', 'Govt Center', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T011');
EXEC add_station('S012', 'Hay markey', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T012');
EXEC add_station('S013', 'North Station', TO_TIMESTAMP('20-MAR-24 07:00:00.45 AM'), 'T013');


