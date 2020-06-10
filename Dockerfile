# Jenkins Docker tag
ARG JENKINS_VERSION=lts-alpine

FROM jenkins/jenkins:${JENKINS_VERSION}

# Docker Channel
ENV DOCKER_CHANNEL=stable

# Docker Version
ENV DOCKER_VERSION=19.03.11

# Jenkins Plugins - a string of space delimitted plugins
ARG JENKINS_PLUGINS="calendar-view"

COPY ./docker-entrypoint.sh /usr/local/bin/

USER root

RUN wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar --extract --file docker.tgz --strip-components 1 --directory /usr/local/bin/ && \
    rm docker.tgz && \
    docker --version

# Add packages, create docker group, add jenkins to the docker group, and make the entrypoint executable
RUN apk add --no-cache \
        shadow \
        'su-exec>=0.2' && \
    addgroup docker && \
    addgroup jenkins docker && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# Install plugins
RUN /usr/local/bin/install-plugins.sh ${JENKINS_PLUGINS}

WORKDIR /var/jenkins_home

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

HEALTHCHECK --interval=30s --timeout=10s CMD curl --fail "http://localhost:8080/login?from=login" || exit 1
