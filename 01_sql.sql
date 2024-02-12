STARTUP
ALTER SYSTEM SET JOB_QUEUE_PROCESSES=0;
ALTER SESSION SET CONTAINER = XEPDB1;
CREATE TABLESPACE APEXDATA DATAFILE '/opt/oracle/oradata/APEXDATA01.dbf' SIZE 1G AUTOEXTEND ON;

@/opt/apex_23.2/apex/apexins APEXDATA APEXDATA TEMP /i/
@/opt/apex_23.2/apex/apxchpwd admin admin@exemple.com PassW0rd!
@/opt/apex_23.2/apex/apex_rest_config PassW0rd! PassW0rd!

--INSTALAR IDIOMA PT-BR
--@/opt/apex_23.2/apex/builder/pt-br/load_pt-br.sql

ALTER SYSTEM SET JOB_QUEUE_PROCESSES=1000;