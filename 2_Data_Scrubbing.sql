SET SERVEROUTPUT ON

DECLARE
    -- Variable to hold count of tables with the given name
    v_table_exists NUMBER;
BEGIN
    -- Check if the table already exists in the user's schema
    SELECT
        COUNT(*)
    INTO v_table_exists
    FROM
        user_tables
    WHERE
        table_name = 'HOLIDAYS'; -- Oracle stores table names in uppercase

    -- If the table does not exist, then create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE holidays (
            holiday_date DATE,
            holiday_type VARCHAR2(20)
        )';
        -- Optionally, output a message to indicate the table was created
        dbms_output.put_line('Table HOLIDAYS created.');
    ELSE
        -- Optionally, output a message to indicate the table already exists
        dbms_output.put_line('Table HOLIDAYS already exists.');
    END IF;

EXCEPTION
    -- Exception handling
    WHEN OTHERS THEN
        -- Output the error message
        dbms_output.put_line('Error occurred: ' || sqlerrm);
        -- Optionally, re-raise the exception if needed
        -- RAISE;
END;
/
DECLARE
    v_table_exists   NUMBER;
    v_constraint_exists   NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO v_table_exists
    FROM user_tables
    WHERE table_name = 'PASSENGER';

    -- If the table does not exist, create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE passenger (
            passenger_id   VARCHAR2(50) NOT NULL,
            passenger_name VARCHAR2(50),
            residual_city  VARCHAR2(50),
            passenger_type VARCHAR2(20)
        )';
        DBMS_OUTPUT.PUT_LINE('Table PASSENGER created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Table PASSENGER already exists.');
    END IF;

    -- Check if the primary key constraint exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE table_name = 'PASSENGER' AND constraint_type = 'P' AND constraint_name = 'PASSENGER_PK';

    -- If the primary key constraint does not exist, add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY (passenger_id)';
        DBMS_OUTPUT.PUT_LINE('Primary key constraint PASSENGER_PK added to table PASSENGER.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Primary key constraint PASSENGER_PK already exists on table PASSENGER.');
    END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/

DECLARE
    v_table_exists   NUMBER;
    v_constraint_exists   NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO v_table_exists
    FROM user_tables
    WHERE table_name = 'PEAK_HOURS';

    -- If the table does not exist, create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE PEAK_HOURS (
            source_station_id VARCHAR2(50),
            target_station_id VARCHAR2(50),
            train_train_id    VARCHAR2(20) NOT NULL,
            peak_hours_id     NUMBER NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Table peak_hours created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Table peak_hours already exists.');
    END IF;

    -- Check if the primary key constraint exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE table_name = 'PEAK_HOURS' AND constraint_type = 'P' AND constraint_name = 'PEAK_HOURS_PK';

    -- If the primary key constraint does not exist, add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE PEAK_HOURS ADD CONSTRAINT PEAK_HOURS_PK PRIMARY KEY (peak_hours_id)';
        DBMS_OUTPUT.PUT_LINE('Primary key constraint PEAK_HOURS_PK added to table PEAK_HOURS.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Primary key constraint PEAK_HOURS_PK already exists on table PEAK_HOURS.');
    END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/

DECLARE
    v_table_exists   NUMBER;
    v_constraint_exists   NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO v_table_exists
    FROM user_tables
    WHERE table_name = 'SCHEDULE';

    -- If the table does not exist, create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE schedule (
            arrival_time       TIMESTAMP,
            departure_time     TIMESTAMP,
            station_station_id VARCHAR2(20) NOT NULL,
            train_train_id     VARCHAR2(20) NOT NULL,
            schedule_id        NUMBER NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Table SCHEDULE created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Table SCHEDULE already exists.');
    END IF;

    -- Check if the primary key constraint exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE table_name = 'SCHEDULE' AND constraint_type = 'P' AND constraint_name = 'SCHEDULE_PK';

    -- If the primary key constraint does not exist, add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY (schedule_id)';
        DBMS_OUTPUT.PUT_LINE('Primary key constraint SCHEDULE_PK added to table SCHEDULE.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Primary key constraint SCHEDULE_PK already exists on table SCHEDULE.');
    END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/

DECLARE
    v_table_exists   NUMBER;
    v_constraint_exists   NUMBER;
BEGIN
    -- Check if the table exists
    SELECT
        COUNT(*)
    INTO v_table_exists
    FROM
        user_tables
    WHERE
        table_name = 'STATION';

    -- If the table does not exist, create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE station (
            station_id     VARCHAR2(20) NOT NULL,
            station_name   VARCHAR2(50),
            arrival_time   TIMESTAMP,
            train_train_id VARCHAR2(20) NOT NULL
        )';
        dbms_output.put_line('Table STATION created.');
    ELSE
        dbms_output.put_line('Table STATION already exists.');
    END IF;

    -- Check if the primary key constraint exists
    SELECT
        COUNT(*)
    INTO v_constraint_exists
    FROM
        user_constraints
    WHERE
            table_name = 'STATION'
        AND constraint_type = 'P'
        AND constraint_name = 'STATION_PK';

    -- If the primary key constraint does not exist, add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE STATION ADD CONSTRAINT station_pk PRIMARY KEY (station_id)';
        dbms_output.put_line('Primary key constraint STATION_PK added to table STATION.');
    ELSE
        dbms_output.put_line('Primary key constraint STATION_PK already exists on table STATION.');
    END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        dbms_output.put_line('An error occurred: ' || sqlerrm);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/

DECLARE
    v_table_exists   NUMBER;
    v_constraint_exists   NUMBER;
BEGIN
    -- Check if the table exists
    SELECT
        COUNT(*)
    INTO v_table_exists
    FROM
        user_tables
    WHERE
        table_name = 'TRAIN';

    -- If the table does not exist, create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE train (
            train_id          VARCHAR2(20) NOT NULL,
            source_station_id VARCHAR2(50) NOT NULL,
            target_station_id VARCHAR2(50),
            train_capacity    INTEGER
        )';
        dbms_output.put_line('Table train created.');
    ELSE
        dbms_output.put_line('Table train already exists.');
    END IF;

    -- Check if the primary key constraint exists
    SELECT
        COUNT(*)
    INTO v_constraint_exists
    FROM
        user_constraints
    WHERE
            table_name = 'TRAIN'
        AND constraint_type = 'P'
        AND constraint_name = 'TRAIN_PK';

        --If the primary key constraint does not exist, add it
       IF v_constraint_exists = 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE TRAIN ADD CONSTRAINT train_pk PRIMARY KEY (train_id)';
            dbms_output.put_line('Primary key constraint TRAIN_PK added to table TRAIN.');
       ELSE
            dbms_output.put_line('Primary key constraint TRAIN_PK already exists on table TRAIN.');
        END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        dbms_output.put_line('An error occurred: ' || sqlerrm);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/

DECLARE
    v_table_exists   NUMBER;
    v_constraint_exists   NUMBER;
BEGIN
    -- Check if the table exists
    SELECT
        COUNT(*)
    INTO v_table_exists
    FROM
        user_tables
    WHERE
        table_name = 'TRANSACTION';

    -- If the table does not exist, create it
    IF v_table_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE transaction (
            transaction_id         VARCHAR2(20) NOT NULL,
            onboard_station_id     VARCHAR2(50),
            offboard_station_id    VARCHAR2(50),
            passenger_count        INTEGER,
            train_train_id         VARCHAR2(20) NOT NULL,
            passenger_passenger_id VARCHAR2(50) NOT NULL
        )';
        dbms_output.put_line('Table transaction created.');
    ELSE
        dbms_output.put_line('Table transaction already exists.');
    END IF;

    -- Check if the primary key constraint exists
    SELECT
        COUNT(*)
    INTO v_constraint_exists
    FROM
        user_constraints
    WHERE
            table_name = 'TRANSACTION'
        AND constraint_type = 'P'
        AND constraint_name = 'TRANSACTION_PK';

        --If the primary key constraint does not exist, add it
       IF v_constraint_exists = 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE TRANSACTION ADD CONSTRAINT transaction_pk PRIMARY KEY (transaction_id)';
            dbms_output.put_line('Primary key constraint TRANSACTION_PK added to table TRANSACTION.');
       ELSE
            dbms_output.put_line('Primary key constraint TRANSACTION_PK already exists on table TRANSACTION.');
        END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        dbms_output.put_line('An error occurred: ' || sqlerrm);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/

DECLARE
    v_constraint_exists NUMBER;
BEGIN
    -- Check if the foreign key constraint exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE constraint_name = 'SCHEDULE_TRAIN_FK';

    -- If the constraint does not exist, add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE schedule ADD CONSTRAINT schedule_train_fk FOREIGN KEY (train_train_id) REFERENCES train (train_id)';
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint SCHEDULE_TRAIN_FK added to table SCHEDULE.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint SCHEDULE_TRAIN_FK already exists on table SCHEDULE.');
    END IF;

EXCEPTION
    -- Exception handling for any errors that may occur during execution
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- Uncomment the following line if you want the script to raise the exception after handling
        -- RAISE;
END;
/
DECLARE
    v_constraint_exists NUMBER;
BEGIN
    -- Check if the foreign key constraint already exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE constraint_name = 'STATION_TRAIN_FK';

    -- If the foreign key constraint does not exist, then add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE station
                           ADD CONSTRAINT station_train_fk FOREIGN KEY (train_train_id)
                           REFERENCES train (train_id)';
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint STATION_TRAIN_FK added to table STATION.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint STATION_TRAIN_FK already exists on table STATION.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- RAISE; -- Uncomment to re-raise the exception after handling
END;
/

DECLARE
    v_constraint_exists NUMBER;
BEGIN
    -- Check if the foreign key constraint already exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE constraint_name = 'TRANSACTION_PASSENGER_FK';

    -- If the foreign key constraint does not exist, then add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE transaction
                           ADD CONSTRAINT transaction_passenger_fk FOREIGN KEY (passenger_passenger_id)
                           REFERENCES passenger (passenger_id)';
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint TRANSACTION_PASSENGER_FK added to table TRANSACTION.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint TRANSACTION_PASSENGER_FK already exists on table TRANSACTION.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- RAISE; -- Uncomment to re-raise the exception after handling
END;
/
DECLARE
    v_constraint_exists NUMBER;
BEGIN
    -- Check if the foreign key constraint already exists
    SELECT COUNT(*)
    INTO v_constraint_exists
    FROM user_constraints
    WHERE constraint_name = 'TRANSACTION_TRAIN_FK';

    -- If the foreign key constraint does not exist, then add it
    IF v_constraint_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE transaction
                           ADD CONSTRAINT transaction_train_fk FOREIGN KEY (train_train_id)
                           REFERENCES train (train_id)';
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint TRANSACTION_TRAIN_FK added to table TRANSACTION.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Foreign key constraint TRANSACTION_TRAIN_FK already exists on table TRANSACTION.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- RAISE; -- Uncomment to re-raise the exception after handling
END;
/

DECLARE
    sequence_count NUMBER;
    trigger_count NUMBER;
BEGIN
    -- Check for 'peak_hours_peak_hours_id_seq' sequence
    SELECT COUNT(*)
    INTO sequence_count
    FROM user_sequences
    WHERE sequence_name = 'PEAK_HOURS_PEAK_HOURS_ID_SEQ';

    IF sequence_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE peak_hours_peak_hours_id_seq START WITH 1 NOCACHE ORDER';
        DBMS_OUTPUT.PUT_LINE('Sequence PEAK_HOURS_PEAK_HOURS_ID_SEQ created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sequence PEAK_HOURS_PEAK_HOURS_ID_SEQ already exists.');
    END IF;

    -- Check for 'peak_hours_peak_hours_id_trg' trigger
    SELECT COUNT(*)
    INTO trigger_count
    FROM user_triggers
    WHERE trigger_name = 'PEAK_HOURS_PEAK_HOURS_ID_TRG';

    IF trigger_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER peak_hours_peak_hours_id_trg BEFORE
                           INSERT ON peak_hours
                           FOR EACH ROW
                           WHEN (new.peak_hours_id IS NULL)
                           BEGIN
                               :new.peak_hours_id := peak_hours_peak_hours_id_seq.nextval;
                           END;';
        DBMS_OUTPUT.PUT_LINE('Trigger PEAK_HOURS_PEAK_HOURS_ID_TRG created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Trigger PEAK_HOURS_PEAK_HOURS_ID_TRG already exists.');
    END IF;

    -- Check for 'schedule_schedule_id_seq' sequence
    SELECT COUNT(*)
    INTO sequence_count
    FROM user_sequences
    WHERE sequence_name = 'SCHEDULE_SCHEDULE_ID_SEQ';

    IF sequence_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE schedule_schedule_id_seq START WITH 1 NOCACHE ORDER';
        DBMS_OUTPUT.PUT_LINE('Sequence SCHEDULE_SCHEDULE_ID_SEQ created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sequence SCHEDULE_SCHEDULE_ID_SEQ already exists.');
    END IF;

    -- Check for 'schedule_schedule_id_trg' trigger
    SELECT COUNT(*)
    INTO trigger_count
    FROM user_triggers
    WHERE trigger_name = 'SCHEDULE_SCHEDULE_ID_TRG';

    IF trigger_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER schedule_schedule_id_trg BEFORE
                           INSERT ON schedule
                           FOR EACH ROW
                           WHEN (new.schedule_id IS NULL)
                           BEGIN
                               :new.schedule_id := schedule_schedule_id_seq.nextval;
                           END;';
        DBMS_OUTPUT.PUT_LINE('Trigger SCHEDULE_SCHEDULE_ID_TRG created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Trigger SCHEDULE_SCHEDULE_ID_TRG already exists.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- RAISE; -- Uncomment to re-raise the exception after handling
END;
/
DECLARE
    sequence_count NUMBER;
    trigger_count NUMBER;
BEGIN
    -- Check for 'transaction_transaction_id_seq' sequence
    SELECT COUNT(*)
    INTO sequence_count
    FROM user_sequences
    WHERE sequence_name = 'TRANSACTION_TRANSACTION_ID_SEQ';

    IF sequence_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE transaction_transaction_id_seq START WITH 1 NOCACHE ORDER';
        DBMS_OUTPUT.PUT_LINE('Sequence TRANSACTION_TRANSACTION_ID_SEQ created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sequence TRANSACTION_TRANSACTION_ID_SEQ already exists.');
    END IF;

    -- Check for 'transaction_transaction_id_trg' trigger
    SELECT COUNT(*)
    INTO trigger_count
    FROM user_triggers
    WHERE trigger_name = 'TRANSACTION_TRANSACTION_ID_TRG';

    IF trigger_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER transaction_transaction_id_trg BEFORE
                           INSERT ON transaction
                           FOR EACH ROW
                           WHEN (new.transaction_id IS NULL)
                           BEGIN
                               :new.transaction_id := transaction_transaction_id_seq.nextval;
                           END;';
        DBMS_OUTPUT.PUT_LINE('Trigger TRANSACTION_TRANSACTION_ID_TRG created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Trigger TRANSACTION_TRANSACTION_ID_TRG already exists.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- RAISE; -- Uncomment to re-raise the exception after handling
END;
/

