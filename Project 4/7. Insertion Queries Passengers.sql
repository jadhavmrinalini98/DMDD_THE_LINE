CREATE OR REPLACE PACKAGE Passenger_Package IS
    -- Declare the procedure to add a passenger
    PROCEDURE add_passenger(
        PASSENGER_ID    IN VARCHAR,
        PASSENGER_NAME  IN VARCHAR,
        RESIDUAL_CITY   IN VARCHAR,
        PASSENGER_TYPE  IN VARCHAR
    );
END Passenger_Package;
/


CREATE OR REPLACE PACKAGE BODY Passenger_Package IS

    PROCEDURE add_passenger(
        PASSENGER_ID    IN VARCHAR,
        PASSENGER_NAME  IN VARCHAR,
        RESIDUAL_CITY   IN VARCHAR,
        PASSENGER_TYPE  IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO PASSENGER (PASSENGER_ID, PASSENGER_NAME, RESIDUAL_CITY, PASSENGER_TYPE)
        VALUES (PASSENGER_ID, PASSENGER_NAME, RESIDUAL_CITY, PASSENGER_TYPE);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data Already Exists or another error occurred: ' || SQLERRM);
        -- Optionally, you might want to rollback or handle the exception differently.
    END add_passenger;

END Passenger_Package;
/

set serveroutput on;
BEGIN
    Passenger_Package.add_passenger('P001', 'Noah', 'Washington St', 'Student');
    Passenger_Package.add_passenger('P002', 'Oliver', 'BU East', 'Professional');
    Passenger_Package.add_passenger('P003', 'Williams', 'BU East', 'Student');
    Passenger_Package.add_passenger('P004', 'James', 'BU East', 'Student');
    Passenger_Package.add_passenger('P005', 'Henery','Washington St', 'Student');
    Passenger_Package.add_passenger('P006', 'Jack', 'BU East', 'Professional');
    Passenger_Package.add_passenger('P007', 'Sean', 'BU East', 'Student');
    Passenger_Package.add_passenger('P008', 'Jacob','Washington St', 'Professional');
    Passenger_Package.add_passenger('P009', 'Luna', 'BU East', 'Student');
    Passenger_Package.add_passenger('P010', 'Ava', 'BU East', 'Student');
    Passenger_Package.add_passenger('P011', 'Sophia','BU East', 'Student');
    Passenger_Package.add_passenger('P012', 'Mary','Washington St', 'Student');
    Passenger_Package.add_passenger('P013', 'Mia', 'Warren St', 'Professional');
    Passenger_Package.add_passenger('P014', 'Olivia', 'Warren St', 'Student');
    Passenger_Package.add_passenger('P015', 'Eva', 'BU East', 'Student');
    Passenger_Package.add_passenger('P016', 'John','Washington St', 'Professional');
    Passenger_Package.add_passenger('P017', 'Madison', 'Warren St','Student');
    Passenger_Package.add_passenger('P018', 'Lana', 'Warren St', 'Professional');
    Passenger_Package.add_passenger('P019', 'Levi', 'Warren St', 'Student');
    Passenger_Package.add_passenger('P020', 'Jackson','Warren St', 'Professional');
    Passenger_Package.add_passenger('P021', 'Thomas','Washington St', 'Student');
END;
/
