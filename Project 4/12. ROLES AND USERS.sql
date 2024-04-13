-- FOR THE PASSENGER ACCESS ...
Create Role Passenger_Role;
Grant SELECT ON PASSENGER TO Passenger_Role;
Grant create session to Passenger_Role;
-- create a new user and then assign that role to him
CREATE USER passenger_user IDENTIFIED BY 'passenger_user_password';
GRANT Passenger_Role TO passenger_user;


-- FOR THE STATION MASTER ACCESS ...
Create Role Station_Role;
Grant SELECT ON STATION TO Station_Role;
Grant create session to Station_Role;
-- create a new user and then assign that role to him
CREATE USER station_user IDENTIFIED BY 'station_user_password';
GRANT Station_Role TO station_user;


-- FOR THE ADMINISTRATOR ACCESS ...
Create Role Administrator_Role;
Grant SELECT ON Schedule to Administrator_Role;
Grant create session to Administrator_Role;
-- create a new user and then assign that role to him
CREATE USER administrator_user IDENTIFIED BY 'admin_user_password';
GRANT Administrator_Role TO administrator_user;