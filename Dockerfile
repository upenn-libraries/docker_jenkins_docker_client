# Jenkins Image Tag
ARG JENKINS_TAG=lts-alpine

FROM jenkins/jenkins:${JENKINS_TAG}

# Channel to use for downloading Docker
ARG DOCKER_CHANNEL=stable

# Name for the Docker group
ARG DOCKER_GROUP=docker
ENV DOCKER_GROUP=${DOCKER_GROUP}

# Version of Docker to install
ARG DOCKER_VERSION=19.03.11

# A string of space delimited plugins
ARG JENKINS_PLUGINS="calendar-view"

COPY ./docker-entrypoint.sh /usr/local/bin/

USER root

# Install Docker
RUN wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar --extract --file docker.tgz --strip-components 1 --directory /usr/local/bin/ && \
    rm docker.tgz && \
    docker --version

# Add packages, create docker group, add jenkins to the docker group, and make the entrypoint executable
RUN apk add --no-cache \
        shadow \
        'su-exec>=0.2' && \
    addgroup ${DOCKER_GROUP} && \
    addgroup jenkins ${DOCKER_GROUP} && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# Install plugins
RUN jenkins-plugin-cli --plugins ${JENKINS_PLUGINS}

WORKDIR /var/jenkins_home

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

HEALTHCHECK --interval=30s --timeout=10s CMD curl --fail "http://localhost:8080/login?from=login" || exit 1
