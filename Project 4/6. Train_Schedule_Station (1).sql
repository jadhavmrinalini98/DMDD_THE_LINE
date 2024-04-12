-- Here is the procedure to add the station into the system
CREATE OR REPLACE PROCEDURE The_Line.add_station(
    p_station_id IN VARCHAR,
    p_station_name IN VARCHAR) 
IS 
BEGIN
    INSERT INTO STATION (STATION_ID, STATION_NAME)
    VALUES (p_station_id, p_station_name);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Data for station ' || p_station_id || ' already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in add_station: ' || SQLERRM);
        RAISE;
END;
/

-- Here is the procedure to create the schedule for a specific train ...
CREATE OR REPLACE PROCEDURE create_schedule(p_current_train IN VARCHAR2, current_train IN INTEGER)
IS
    v_counter INTEGER := 1; -- Corrected variable name
    start_timestamp TIMESTAMP;
    end_timestamp TIMESTAMP;
BEGIN
    start_timestamp := TO_TIMESTAMP('20-MAR-24 07:00:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM');
    start_timestamp := start_timestamp + NUMTODSINTERVAL( (current_train-1), 'HOUR');
    end_timestamp := TO_TIMESTAMP('20-MAR-24 07:03:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM');
    end_timestamp := end_timestamp + NUMTODSINTERVAL( (current_train-1), 'HOUR');

    FOR i IN 1..13 LOOP
        DBMS_OUTPUT.PUT_LINE('Inserting schedule for train: ' || p_current_train || ' and ' || 'S' || LPAD(v_counter, 3, '0'));
        
        INSERT INTO SCHEDULE(ARRIVAL_TIME, DEPARTURE_TIME, STATION_STATION_ID, TRAIN_TRAIN_ID, SCHEDULE_ID)
        VALUES (
            start_timestamp + NUMTODSINTERVAL((i-1)*10, 'MINUTE'),
            end_timestamp + NUMTODSINTERVAL((i-1)*10, 'MINUTE'),
            'S' || LPAD(v_counter, 3, '0'),
            p_current_train,
            schedule_schedule_id_seq.NEXTVAL -- Assuming sequence exists
        );
        COMMIT;
        v_counter := v_counter + 1;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating schedule for train ' || p_current_train || ': ' || SQLERRM);
        RAISE;
END;
/

-- Here is the type declaration...
CREATE OR REPLACE TYPE namearray AS VARRAY(15) OF VARCHAR2(50);
/

-- Here is the create environment setup
set serveroutput on
CREATE OR REPLACE PROCEDURE The_Line.create_environment
IS 
    v_train_id VARCHAR2(20);
    required_timestamp TIMESTAMP;
    t_counter INTEGER := 6;
    p_train_capacity INTEGER := 100; 
    stations namearray := namearray(
        'Boston College', 'Washington St', 'Warren St', 'Babcock St', 
        'Amory St', 'Boston Central', 'Boston East', 'Kenmore', 
        'Hymn', 'Arlington', 'Govt Center', 'Haymarket', 'North Station'
    ); -- Haymarket was misspelled and one station name was missing. Adjust as necessary.
    p_source_station VARCHAR2(20) := 'S001';
    p_target_station_id VARCHAR2(20) := 'S013';

BEGIN
    FOR current_train IN 1..20 LOOP
        v_train_id := 'T' || LPAD(TRAIN_ID_SEQ.NEXTVAL, 2, '0');
        DBMS_OUTPUT.PUT_LINE('Inserting Data [Train]: ' || v_train_id);
        
        required_timestamp := TO_TIMESTAMP('20-MAR-24 07:00:00.00 AM', 'DD-MON-RR HH:MI:SS.FF AM');
        required_timestamp := required_timestamp + NUMTODSINTERVAL( (current_train-1), 'HOUR');

        INSERT INTO TRAIN(TRAIN_ID, SOURCE_STATION_ID, TARGET_STATION_ID, TRAIN_CAPACITY, SOURCE_TIME)
        VALUES (v_train_id, p_source_station, p_target_station_id, p_train_capacity, required_timestamp);

        -- Now, create the stations-schedule for the train
        IF current_train = 1 THEN
            FOR i IN 1..stations.COUNT LOOP
                The_Line.add_station(
                    'S' || LPAD(i, 3, '0'),
                    stations(i)
                );
            END LOOP;
        END IF;


        COMMIT; -- Ensure that station records are committed before schedule creation

        -- Now, create the schedule for the train
        create_schedule(v_train_id, current_train);
    END LOOP;
    COMMIT; -- Final commit after all insertions are done
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in add_train: ' || SQLERRM);
        RAISE;
END;
/

EXEC The_Line.create_environment();

CREATE OR REPLACE VIEW station_book AS
    SELECT 
        a.STATION_STATION_ID as station_id, 
        a.TRAIN_TRAIN_ID as train_id, 
        a.ARRIVAL_TIME as arrival_time, 
        b.STATION_NAME as station_name
    from schedule a inner join station b 
        on a.STATION_STATION_ID = b.STATION_ID;

select * from station_book;


