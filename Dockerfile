FROM container-registry.oracle.com/database/express:21.3.0-xe

USER root

ARG ORACLE_PWD
ARG ORDS_CONFIG
ARG ORDS_LOGS
ARG DB_PORT
ARG DB_SERVICE
ARG SYSDBA_USER
ARG HOSTNAME_

RUN mkdir -p /opt/config/logs/

RUN yum update -y && yum install java-11-openjdk.x86_64 -y \
   && yum-config-manager --add-repo=http://yum.oracle.com/repo/OracleLinux/OL7/oracle/software/x86_64 \
   && yum install ords -y && yum install nano -y

RUN curl -o /tmp/apex_23.2.zip https://download.oracle.com/otn_software/apex/apex_23.2.zip

RUN unzip /tmp/apex_23.2.zip -d /opt/apex_23.2/

USER oracle

COPY 01_sql.sql .

WORKDIR /opt/apex_23.2/apex/

RUN sqlplus / as sysdba @/home/oracle/01_sql

WORKDIR /home/oracle/

USER root
RUN chmod -R 777 /opt/config/
USER oracle

COPY password .
COPY 02_sql.sql .

RUN lsnrctl start && sqlplus / as sysdba @02_sql & sleep 60 && ./setPassword.sh ${ORACLE_PWD} && lsnrctl status && ords --config ${ORDS_CONFIG} install --log-folder ${ORDS_LOGS}  --admin-user ${SYSDBA_USER}  --db-hostname ${HOSTNAME_}  --db-port ${DB_PORT} --db-servicename ${DB_SERVICE} --feature-db-api true --feature-rest-enabled-sql true --feature-sdw true    --gateway-mode proxied  --gateway-user APEX_PUBLIC_USER --proxy-user --password-stdin < password

WORKDIR /opt/oracle/