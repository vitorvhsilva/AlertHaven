# build maven
FROM maven:3.9.9-eclipse-temurin-23 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# build api
FROM openjdk:23-jdk

# criando usuario nao-root
ENV APP_USER=appuser \
    APP_HOME=/opt/alert-haven \
    APP_PORT=8080

RUN useradd -m -d ${APP_HOME} ${APP_USER} && \
    chown ${APP_USER}:${APP_USER} ${APP_HOME}

# setando workdir
WORKDIR ${APP_HOME}
RUN chown ${APP_USER}:${APP_USER} ${APP_HOME}

COPY --from=build --chown=${APP_USER}:${APP_USER} /app/target/AlertHaven-0.0.1-SNAPSHOT.jar ${APP_HOME}/app.jar

USER ${APP_USER}

EXPOSE ${APP_PORT}

CMD ["java", "-jar", "app.jar"]