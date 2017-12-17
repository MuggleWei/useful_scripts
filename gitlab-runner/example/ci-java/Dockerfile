FROM muggle.docker.com/jdk8
MAINTAINER Muggle Wei "mugglewei@gmail.com"
ENV REFRESHED_AT "2017-12-17 22:41"

COPY target/ci-java-1.0-SNAPSHOT-jar-with-dependencies.jar /deploy/
WORKDIR /deploy
CMD ["java", "-jar", "ci-java-1.0-SNAPSHOT-jar-with-dependencies.jar"]