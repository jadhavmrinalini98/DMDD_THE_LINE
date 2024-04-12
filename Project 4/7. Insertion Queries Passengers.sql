set serveroutput on
CREATE OR REPLACE 
    PROCEDURE The_Line.add_passenger(
        PASSENGER_ID in VARCHAR,
        PASSENGER_NAME in VARCHAR,
        RESIDUAL_CITY in VARCHAR,
        PASSENGER_TYPE in VARCHAR) 
    IS 
BEGIN
    INSERT INTO
        PASSENGER (PASSENGER_ID, PASSENGER_NAME, RESIDUAL_CITY, PASSENGER_TYPE)
        VALUES ( PASSENGER_ID, PASSENGER_NAME, RESIDUAL_CITY, PASSENGER_TYPE);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data Already Exists.');
END;
/
EXEC add_passenger('P001', 'Noah', 'Washington St', 'Student');
EXEC add_passenger('P002', 'Oliver', 'BU East', 'Professional');
EXEC add_passenger('P003', 'Williams', 'BU East', 'Student');
EXEC add_passenger('P004', 'James', 'BU East', 'Student');
EXEC add_passenger('P005', 'Henery','Washington St', 'Student');
EXEC add_passenger('P006', 'Jack', 'BU East', 'Professional');
EXEC add_passenger('P007', 'Sean', 'BU East', 'Student');
EXEC add_passenger('P008', 'Jacob','Washington St', 'Professional');
EXEC add_passenger('P009', 'Luna', 'BU East', 'Student');
EXEC add_passenger('P010', 'Ava', 'BU East', 'Student');
EXEC add_passenger('P011', 'Sophia','BU East', 'Student');
EXEC add_passenger('P012', 'Mary','Washington St', 'Student');
EXEC add_passenger('P013', 'Mia', 'Warren St', 'Professional');
EXEC add_passenger('P014', 'Olivia', 'Warren St', 'Student');
EXEC add_passenger('P015', 'Eva', 'BU East', 'Student');
EXEC add_passenger('P016', 'John','Washington St', 'Professional');
EXEC add_passenger('P017', 'Madison', 'Warren St','Student');
EXEC add_passenger('P018', 'Lana', 'Warren St', 'Professional');
EXEC add_passenger('P019', 'Levi', 'Warren St', 'Student');
EXEC add_passenger('P020', 'Jackson','Warren St', 'Professional');
EXEC add_passenger('P021', 'Thomas','Washington St', 'Student');
