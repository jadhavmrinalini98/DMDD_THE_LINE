SET SERVEROUTPUT ON;
DECLARE
    v_user_count NUMBER;
    user_name VARCHAR2(30) := 'THE_LINE';
    requiredPassword VARCHAR2(50) := 'newPassword@12345'; -- Specify the maximum size of the password
BEGIN
    -- Check if the user already exists
    SELECT COUNT(*)
    INTO v_user_count
    FROM all_users -- Use all_users if you don't have access to dba_users
    WHERE UPPER(username) = UPPER(user_name);

    -- If the user does not exist, create the user
    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER ' || user_name || ' IDENTIFIED BY "' || requiredPassword || '"';
        EXECUTE IMMEDIATE 'GRANT CONNECT TO ' || user_name;
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO ' || user_name;
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO ' || user_name;
        EXECUTE IMMEDIATE 'ALTER USER ' || user_name || ' QUOTA UNLIMITED ON USERS';
        DBMS_OUTPUT.PUT_LINE('User ' || user_name || ' created with the necessary privileges.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User ' || user_name || ' already exists.');
        -- Grant privileges
        EXECUTE IMMEDIATE 'GRANT CONNECT TO ' || user_name;
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO ' || user_name;
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO ' || user_name;
        EXECUTE IMMEDIATE 'ALTER USER ' || user_name || ' QUOTA UNLIMITED ON USERS';
        DBMS_OUTPUT.PUT_LINE('Privileges are ensured for user ' || user_name || '.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        -- RAISE; -- Uncomment to re-raise the exception after handling
END;
/
