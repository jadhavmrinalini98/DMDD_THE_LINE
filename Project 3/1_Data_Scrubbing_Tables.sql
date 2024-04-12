set serveroutput on
declare
    all_tables varchar(1) := 'Y';
    required_sql_query varchar(2000);
begin
   dbms_output.put_line('Cleaning up all the Tables ...');
   for i in (select table_name from user_tables)
   loop
   dbms_output.put_line('[DELETED] : '||i.table_name);
   begin
       select 'Y' into all_tables
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       required_sql_query := 'drop table '||i.table_name ||' cascade constraints';   
       execute immediate required_sql_query;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
