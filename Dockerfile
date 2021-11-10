ARG MCMS_VERSION="5.2.4"

FROM maven:3.8.3-jdk-8
ARG MCMS_VERSION
RUN wget -q "https://gitee.com/mingSoft/MCMS/repository/archive/${MCMS_VERSION}?format=tar.gz" -O MCMS-${MCMS_VERSION}.tar.gz && \
    tar -xzf MCMS-${MCMS_VERSION}.tar.gz && \
    cd MCMS-${MCMS_VERSION} && \
    # Set the package format to war
    sed -i "s/.*<packaging>war.*/    <packaging>war<\/packaging>/g" pom.xml && \
    # Get the database connection info from environment variables
    sed -i "s/localhost/\${MYSQL_HOST}/" src/main/resources/application-dev.yml && \
    sed -i "s/3306/\${MYSQL_PORT}/" src/main/resources/application-dev.yml && \
    sed -i "s/mcms/\${MYSQL_DATABASE}/" src/main/resources/application-dev.yml && \
    sed -i "s/username.*/username: \${MYSQL_USER}/" src/main/resources/application-dev.yml && \
    sed -i "s/password.*/password: \${MYSQL_PASSWORD}/" src/main/resources/application-dev.yml && \
    mvn clean package && \
    ls -lh target/

FROM tomcat:9.0.54-jre8-temurin
ARG MCMS_VERSION
ENV MYSQL_HOST="localhost" \
    MYSQL_PORT="3306" \
    MYSQL_DATABASE="mcms" \
    MYSQL_USER="root" \
    MYSQL_PASSWORD="root"

COPY --from=0 /MCMS-${MCMS_VERSION}/target/ms-mcms.war /usr/local/tomcat/webapps/ROOT.war

