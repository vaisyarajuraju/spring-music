FROM openjdk:11
VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} spring-music.jar
ENTRYPOINT ["java","-jar","/spring-music.jar"]
