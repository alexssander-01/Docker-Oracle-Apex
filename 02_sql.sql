startup
ALTER SESSION SET CONTAINER = XEPDB1;
set serveroutput on
create table ativo(
	is_ativo char(1)
);
insert into ativo(is_ativo) values ('S');
commit;
DECLARE
 	v_alexss CHAR(1);
begin
	FOR I IN 1..750
	LOOP
		SELECT * INTO V_ALEXSS FROM ATIVO;
		EXIT WHEN V_ALEXSS != 'S';
		DBMS_LOCK.SLEEP(1);
	END LOOP;
end;
/
DROP TABLE ATIVO;
COMMIT;