FROM jenkins/jenkins:lts

USER root
WORKDIR /tmp

# Install Docker client
ENV DOCKER_VERSION=18.09.6
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    mv docker-${DOCKER_VERSION}.tgz docker.tgz && \
    tar xzvf docker.tgz && \
    mv docker/docker /usr/local/bin && \
    rm -r docker docker.tgz

# Add Jenkins to Docker group with same GID on host
ARG DOCKER_GID=993
RUN groupadd -g $DOCKER_GID docker && \
    usermod -a -G docker jenkins

USER jenkins
WORKDIR /var/jenkins_home

EXPOSE 8080
