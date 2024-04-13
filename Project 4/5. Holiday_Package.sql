create or replace PACKAGE holiday_mgmt IS
  -- Procedure to add a holiday directly
  PROCEDURE add_holiday(
      holiday_date IN VARCHAR, 
      holiday_type IN VARCHAR
  );

  -- Function to check if a holiday exists
  FUNCTION holiday_exists(
      required_date IN VARCHAR
  ) RETURN BOOLEAN;

  -- Procedure to check for a holiday's existence and add it if it doesn't exist
END holiday_mgmt;