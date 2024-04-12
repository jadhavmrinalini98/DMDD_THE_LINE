set serveroutput on
CREATE OR REPLACE PROCEDURE create_schedule(requiredValue IN VARCHAR2)
IS
    counter INTEGER; -- Declaring counter variable
BEGIN
    FOR current_train IN 1..20 LOOP
        counter := 1; -- Initialize counter within the loop
        FOR current_time IN 0..11 LOOP
            DBMS_OUTPUT.PUT_LINE('Inserting Data [Train]: ' || current_train);
            IF (counter > 9) THEN
                INSERT INTO SCHEDULE(ARRIVAL_TIME, DEPARTURE_TIME, STATION_STATION_ID, TRAIN_TRAIN_ID, SCHEDULE_ID)
                    VALUES (
                        TO_TIMESTAMP('20-MAR-24 07:' || (current_time * 5) ||':00.45 AM'),
                        TO_TIMESTAMP('20-MAR-24 07:' || ((current_time * 5) + 2) ||':00.45 AM'),
                        'S0' || counter, -- Corrected concatenation operator
                        'T0' || current_train,
                        schedule_schedule_id_seq.nextval
                    );
                COMMIT;
            ELSE
                INSERT INTO SCHEDULE(ARRIVAL_TIME, DEPARTURE_TIME, STATION_STATION_ID, TRAIN_TRAIN_ID, SCHEDULE_ID)
                    VALUES (
                        TO_TIMESTAMP('20-MAR-24 07:' || (current_time * 5) ||':00.45 AM'),
                        TO_TIMESTAMP('20-MAR-24 07:' || ((current_time * 5) + 2) ||':00.45 AM'),
                        'S00' || counter, -- Corrected concatenation operator
                        'T0' || current_train,
                        schedule_schedule_id_seq.nextval
                    );
                COMMIT;
            END IF;
            counter := counter + 1; -- Increment counter
        END LOOP;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data Already Exists.');
END;
/

EXEC create_schedule( 'xyz');





