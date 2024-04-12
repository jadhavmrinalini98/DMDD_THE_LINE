set serveroutput on
declare
    all_sequences varchar(1) := 'Y';
    required_sql_query varchar(2000);
begin
   dbms_output.put_line('Cleaning up all the Sequences ...');
   for i in (select SEQUENCE_NAME from user_sequences)
   loop
   dbms_output.put_line('[DELETED] : '||i.SEQUENCE_NAME);
   begin
       select 'Y' into all_sequences
       from user_sequences
       where SEQUENCE_NAME=i.SEQUENCE_NAME;

       required_sql_query := 'DROP SEQUENCE '||i.SEQUENCE_NAME;   
       execute immediate required_sql_query;
       dbms_output.put_line('........Sequence '||i.SEQUENCE_NAME||' dropped successfully');
   exception
       when no_data_found then
           dbms_output.put_line('........Sequence already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
