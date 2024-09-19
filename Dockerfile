FROM ubuntu

ARG MAVEN_VERSION=2.2.1
ARG USER_HOME_DIR="/root"
ARG BASE_URL=http://archive.apache.org/dist/maven/maven-2/${MAVEN_VERSION}/binaries


RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# install java
ADD jdk-1_5_0_22-linux-amd64.bin /tmp/jdk-1_5_0_22-linux-amd64.bin
RUN \
    echo yes|sh /tmp/jdk-1_5_0_22-linux-amd64.bin ;\
    rm /tmp/jdk-1_5_0_22-linux-amd64.bin


ENV JAVA_HOME /jdk1.5.0_22
ENV PATH /jdk1.5.0_22/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


# Define default command.
CMD ["mvn"]
