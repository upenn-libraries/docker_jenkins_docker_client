# Jenkins with Docker Client

This is an Alpine build of [Jenkins](https://jenkins.io/). It includes a Docker client for DinD and an entrypoint script to change the container Docker GID to match the host.

## Build Arguments:

| Name | Default | Function |
| --- | --- | --- |
| DOCKER_CHANNEL | stable | Channel to use for downloading Docker |
| DOCKER_GROUP | docker | Name for the Docker group |
| DOCKER_VERSION | 19.03.11 | Version of Docker to install |
| JENKINS_PLUGINS | calendar-view | A string of space delimitted plugins |
| JENKINS_TAG | lts-alpine | Jenkins Image Tag (global arg) |
