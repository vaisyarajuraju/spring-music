FROM gradle:7.4.0-jdk11 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
run gradle build  --no-daemon

#Run vulnerability scan on build image
FROM build AS vulnscan
COPY --from=aquasec/trivy:latest /usr/local/bin/trivy /usr/local/bin/trivy
RUN trivy rootfs --no-progress /

#FROM build AS zegl
#run -v $(pwd):/project zegl/kube-score:latest score deploymentservice.yaml

FROM openjdk:11
EXPOSE 8080
RUN mkdir /app
#RUN ls ~/src/build/libs/
RUN sleep 1m
COPY  --from=build /home/gradle/src/build/libs/src-1.0.jar /app/spring-music.jar
ENTRYPOINT ["java", "-DJava.security.egd=file:/dev.urandom", "-jar","/app/spring-music.jar"]
#FROM openjdk:11
#VOLUME /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE} spring-music.jar
#ENTRYPOINT ["java","-jar","/spring-music.jar"]
