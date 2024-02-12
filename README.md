# Oracle Database with APEX and ORDS Docker Setup
This Docker configuration allows you to build an image for Oracle Database with APEX (Oracle Application Express) and ORDS (Oracle REST Data Services) installed, ready for immediate use. Below is an explanation of the Dockerfile and Docker Compose configuration.

## Usage
1. Make sure you have Docker and Docker Compose installed.
2. Place the Dockerfile and Docker Compose YAML file in the same directory.
3. Set necessary environment variables or update the Docker Compose file with appropriate values.
4. Run docker-compose build to build the image.
5. Once the image is built, run docker-compose up to start the container.
6. Access the Oracle APEX container with Docker by executing:
7. docker exec -it oracleapex23.2 /bin/bash
8. Define the Oracle APEX internal user by navigating to:
   - ~~~sh
      cd /opt/apex_23.2/apex/
     ~~~
   - ~~~sql
     sqlplus / as sysdba
     alter session set container=xepdb1;
     @apxchpwd
     ~~~
9. Start the Oracle ORDS server using:
   - ~~~sh
      ords --config /opt/config serve --apex-images /opt/apex_23.2/apex/images >/dev/null 2>&1 &

### Important: make changes to the passwords in the .env and password files, make the necessary modifications as deemed appropriate.