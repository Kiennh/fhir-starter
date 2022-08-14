FROM alpine/git as fetch-hapi
WORKDIR /tmp
RUN git clone https://github.com/hapifhir/hapi-fhir-jpaserver-starter.git /tmp
# RUN git checkout v5.7.0

##

FROM maven:3.8-openjdk-17-slim as build-hapi
WORKDIR /tmp
COPY --from=fetch-hapi /tmp /tmp


ARG OPENTELEMETRY_JAVA_AGENT_VERSION=1.15.0
RUN curl -LSsO https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OPENTELEMETRY_JAVA_AGENT_VERSION}/opentelemetry-javaagent.jar
RUN mvn -ntp dependency:go-offline

RUN mvn -ntp clean install -DskipTests -Djdk.lang.Process.launchMechanism=vfork

##

FROM tomcat:9.0.62-jdk17-openjdk-slim
RUN mkdir -p /data/hapi/lucenefiles && chmod 775 /data/hapi/lucenefiles

COPY --from=build-hapi ./tmp/target/ROOT /usr/local/tomcat/webapps/ROOT

COPY ./templates/. /usr/local/tomcat/webapps/ROOT/WEB-INF/templates
COPY ./img/. /usr/local/tomcat/webapps/ROOT/img/

EXPOSE 8080

CMD ["catalina.sh", "run"]
