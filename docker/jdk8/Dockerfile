FROM ubuntu:16.04
MAINTAINER Muggle Wei "mugglewei@gmail.com"
ENV REFRESHED_AT "2017-12-17 22:31"

COPY resources/jdk-8u131-linux-x64.tar.gz /tmp/
RUN tar -xzvf /tmp/jdk-8u131-linux-x64.tar.gz -C /opt
RUN rm -rf /tmp/jdk-8u131-linux-x64.tar.gz
ENV JAVA_HOME /opt/jdk1.8.0_131
ENV PATH $JAVA_HOME/bin:$PATH
