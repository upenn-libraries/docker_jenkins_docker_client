# Jenkins with Docker Client

This is an Alpine build of [Jenkins](https://jenkins.io/). It includes a Docker client for DinD and an entrypoint script to change the container Docker GID to match the host.

## Build Arguments:

| Name | Default | Function |
| --- | --- | --- |
| JENKINS_PLUGINS | calendar-view | A string of space delimitted plugins |
| JENKINS_VERSION | lts | Jenkins Version (global arg) |
