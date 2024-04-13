set serveroutput on
declare
    v_user_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start user cleanup');
   for i in (select USERNAME from all_users
        WHERE USERNAME in(
            'PASSENGER_USER',
            'STATION_USER',
            'ADMINISTRATOR_USER'
        )
    ) loop
        dbms_output.put_line('....Drop user '||i.USERNAME);
        FOR r IN (select sid,serial# from v$session where USERNAME in (i.USERNAME) ) LOOP
            EXECUTE IMMEDIATE 'alter system kill session ''' || r.sid  || ',' 
                || r.serial# || ''' immediate';
        END LOOP;

        begin
            select 'Y' into v_user_exists
                from all_users
                where USERNAME= i.USERNAME;

            v_sql := 'drop user '||i.USERNAME;
            execute immediate v_sql;
            dbms_output.put_line('........User '||i.USERNAME||' dropped successfully');
       
            exception
                when no_data_found then
                dbms_output.put_line('........User already dropped');
        end;
    end loop;
    dbms_output.put_line('User cleanup successfully completed');
exception
    when others then
    dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/




--Role CLEANUP SCRIPT
set serveroutput on
declare
    v_role_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
    dbms_output.put_line('Start role cleanup');
    for i in (select distinct role from DBA_ROLES
        where role in (
            'PASSENGER_ROLE',
            'STATION_ROLE',
            'ADMINISTRATOR_ROLE'
        )
    ) LOOP
        dbms_output.put_line('....Drop role '||i.role);
        begin
            select 'Y' into v_role_exists from DBA_ROLES
                where role= i.role;

            v_sql := 'drop role '||i.role;
            execute immediate v_sql;
            dbms_output.put_line('........Role '||i.role||' dropped successfully');
        
            exception
                when no_data_found then
                    dbms_output.put_line('........Role already dropped');
        end;
    end loop;
    dbms_output.put_line('Role cleanup successfully completed');
exception
    when others then
        dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/


-- FOR THE PASSENGER ACCESS ...
Create Role Passenger_Role;
Grant SELECT ON PASSENGER TO Passenger_Role;
Grant create session to Passenger_Role;
-- create a new user and then assign that role to him
CREATE USER passenger_user IDENTIFIED BY "Password#2024";
GRANT Passenger_Role TO passenger_user;


-- FOR THE STATION MASTER ACCESS ...
Create Role Station_Role;
Grant SELECT ON STATION TO Station_Role;
Grant create session to Station_Role;
-- create a new user and then assign that role to him
CREATE USER station_user IDENTIFIED BY "Password#2024";
GRANT Station_Role TO station_user;


-- FOR THE ADMINISTRATOR ACCESS ...
Create Role Administrator_Role;
Grant SELECT ON Schedule to Administrator_Role;
Grant create session to Administrator_Role;
-- create a new user and then assign that role to him
CREATE USER administrator_user IDENTIFIED BY "Password#2024";
GRANT Administrator_Role TO administrator_user;