set serveroutput on;
BEGIN
  holiday_mgmt.add_holiday('2024-10-31', 'Halloween');
  holiday_mgmt.add_holiday('2024-07-04', 'Independence Day');
  holiday_mgmt.add_holiday('2024-01-01', 'New Year');
  holiday_mgmt.add_holiday('2024-02-14', 'Valentines Day');
  holiday_mgmt.add_holiday('2024-02-19', 'Presidents Day');
  holiday_mgmt.add_holiday('2024-03-17', 'St. Patricks Day');
  holiday_mgmt.add_holiday('2024-03-31', 'Easter Sunday');
  holiday_mgmt.add_holiday('2024-04-01', 'Easter Monday');
  holiday_mgmt.add_holiday('2024-05-12', 'Mothers Day');
  holiday_mgmt.add_holiday('2024-05-27', 'Memorial Day');
  holiday_mgmt.add_holiday('2024-07-16', 'Fathers Day');
  holiday_mgmt.add_holiday('2024-09-02', 'Labor Day');
  holiday_mgmt.add_holiday('2024-11-11', 'Veterans Day');
  holiday_mgmt.add_holiday('2024-11-28', 'Thanksgiving Day');
  holiday_mgmt.add_holiday('2024-11-29', 'Black Friday');
  holiday_mgmt.add_holiday('2024-12-24', 'Christmas Eve');
  holiday_mgmt.add_holiday('2024-12-25', 'Christmas');
  holiday_mgmt.add_holiday('2024-12-31', 'New Years Eve');
END;
/