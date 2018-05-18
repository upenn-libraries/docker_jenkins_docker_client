FROM jenkins/jenkins:lts

USER root
WORKDIR /tmp

# Install Docker client
ENV DOCKER_VERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    mv docker-${DOCKER_VERSION}.tgz docker.tgz && \
    tar xzvf docker.tgz && \
    mv docker/docker /usr/local/bin && \
    rm -r docker docker.tgz

USER jenkins
WORKDIR /var/jenkins_home

EXPOSE 8080
