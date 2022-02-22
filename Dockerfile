FROM gradle:7.4.0-jdk11 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
run gradle build  --no-daemon


FROM openjdk:11

EXPOSE 8080

RUN mkdir /app

COPY  --from=build /home/gradle/src/build/libs/spring-music-1.0.jar /app/spring-music.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-DJava.security.egd=file:/dev.urandom", "-jar","/app/spring-music.jar"]

#FROM openjdk:11
#VOLUME /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE} spring-music.jar
#ENTRYPOINT ["java","-jar","/spring-music.jar"]
