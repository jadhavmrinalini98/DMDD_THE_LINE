CREATE OR REPLACE PACKAGE BODY holiday_mgmt IS

  -- Function to check if the holiday already exists
  FUNCTION holiday_exists(required_date IN VARCHAR) RETURN BOOLEAN IS
    v_count NUMBER;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Functions: ' || required_date);
    -- Assuming holiday_date is passed in 'YYYY-MM-DD' format and HOLIDAYS.holiday_date is a DATE type
  
    SELECT COUNT(*) into v_count
    FROM HOLIDAYS
    WHERE holiday_date = TO_DATE(required_date, 'YYYY-MM-DD'); 

    DBMS_OUTPUT.PUT_LINE('Checking existence for: ' || required_date || ' Found count: ' || v_count);
    RETURN (v_count > 0);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error checking holiday: ' || SQLERRM);
      RETURN FALSE;  -- Safely return FALSE if an error occurs
  END holiday_exists;

  -- Procedure to add a new holiday
  PROCEDURE add_holiday(holiday_date IN VARCHAR, holiday_type IN VARCHAR) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Attempting to add holiday on: ' || holiday_date);
    -- Use the function to check if the holiday already exists
    IF holiday_exists(holiday_date) THEN
      DBMS_OUTPUT.PUT_LINE('Holiday already exists. No action taken.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Holiday does not exist. Adding new holiday.');
      INSERT INTO HOLIDAYS(holiday_date, holiday_type)
      VALUES (TO_DATE(holiday_date, 'YYYY-MM-DD'), holiday_type);
      commit;
      DBMS_OUTPUT.PUT_LINE('Holiday added successfully.');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error occurred while adding holiday: ' || SQLERRM);
      RAISE;  -- Reraising the exception is typically a good practice unless specifically handled
  END add_holiday;

END holiday_mgmt;
/