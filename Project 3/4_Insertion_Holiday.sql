set serveroutput on
CREATE OR REPLACE 
    PROCEDURE The_Line.add_holiday(
        holiday_date in VARCHAR, 
        holiday_type in VARCHAR) 
    IS 
BEGIN
    INSERT INTO
        HOLIDAYS(holiday_date, holiday_type)
        VALUES (TO_DATE( holiday_date, 'YYYY-MM-DD'), holiday_type);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('Data Already Exists.');
END;
/ 

EXEC add_holiday('2024-10-31', 'Halloween');
EXEC add_holiday('024-07-04', 'Independence Day');
EXEC add_holiday('2024-01-01', 'New Year');
EXEC add_holiday('2024-02-14', 'Valentines Day');
EXEC add_holiday('2024-02-19', 'Presidents Day');
EXEC add_holiday('2024-03-17', 'St. Patricks Day');
EXEC add_holiday('2024-03-31', 'Easter Sunday');
EXEC add_holiday('2024-04-01', 'Easter Monday');
EXEC add_holiday('2024-05-12', 'Mothers Day');
EXEC add_holiday('2024-05-27', 'Memorial Day');
EXEC add_holiday('2024-07-16', 'Fathers Day');
EXEC add_holiday('2024-09-02', 'Labor Day');
EXEC add_holiday('2024-11-11', 'Veterans Day');
EXEC add_holiday('2024-11-28', 'Thanksgiving Day');
EXEC add_holiday('2024-11-29', 'Black Friday');
EXEC add_holiday('2024-12-24', 'Christmas Eve');
EXEC add_holiday('2024-12-25', 'Christmas');
EXEC add_holiday('2024-12-31', 'New Years Eve');
