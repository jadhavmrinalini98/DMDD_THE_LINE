-------Cleanup for triggers-------
SET SERVEROUTPUT ON;
DECLARE
    required_sql_query VARCHAR2(2000);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Cleaning up all the Triggers ...');

    FOR i IN (SELECT TRIGGER_NAME FROM user_triggers)
    LOOP
        DBMS_OUTPUT.PUT_LINE('[DELETED] : ' || i.TRIGGER_NAME);
        BEGIN
            required_sql_query := 'DROP TRIGGER ' || i.TRIGGER_NAME;
            EXECUTE IMMEDIATE required_sql_query;
            DBMS_OUTPUT.PUT_LINE('........Trigger ' || i.TRIGGER_NAME || ' dropped successfully');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('........Failed to drop trigger ' || i.TRIGGER_NAME || ': ' || SQLERRM);
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Schema cleanup successfully completed');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to execute code:' || SQLERRM);
END;
-------Cleanup for views-------
SET SERVEROUTPUT ON;
DECLARE
    required_sql_query VARCHAR2(2000);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Cleaning up all the Views ...');

    FOR i IN (SELECT VIEW_NAME FROM user_views)
    LOOP
        DBMS_OUTPUT.PUT_LINE('[DELETED] : ' || i.VIEW_NAME);
        BEGIN
            required_sql_query := 'DROP VIEW ' || i.VIEW_NAME;
            EXECUTE IMMEDIATE required_sql_query;
            DBMS_OUTPUT.PUT_LINE('........View ' || i.VIEW_NAME || ' dropped successfully');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('........Failed to drop view ' || i.VIEW_NAME || ': ' || SQLERRM);
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Schema cleanup successfully completed');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to execute code:' || SQLERRM);
END;
