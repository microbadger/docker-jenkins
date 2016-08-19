# Dockerized Jenkins - Custom

[![Build Status](https://travis-ci.org/HearstAT/docker-jenkins.svg?branch=master)](https://travis-ci.org/HearstAT/docker-jenkins) [![GitHub release](https://img.shields.io/github/release/TheFynx/docker-jenkins-job-builder.svg?maxAge=2592000)](https://github.com/TheFynx/docker-jenkins-job-builder/releases) [![Docker Automated buil](https://img.shields.io/docker/automated/hearstat/docker-jenkins.svg?maxAge=2592000)](https://hub.docker.com/r/hearstat/docker-jenkins/) [![Docker Stars](https://img.shields.io/docker/stars/hearstat/docker-jenkins.svg?maxAge=2592000)](https://hub.docker.com/r/hearstat/docker-jenkins/) [![Docker Pulls](https://img.shields.io/docker/pulls/hearstat/docker-jenkins.svg?maxAge=2592000)](https://hub.docker.com/r/hearstat/docker-jenkins/)


The Jenkins Continuous Integration and Delivery server.

This is a fully functional Jenkins server, based on the Long Term Support release.
[http://jenkins.io/](http://jenkins.io/).

<img src="http://jenkins-ci.org/sites/default/files/jenkins_logo.png"/>

# Usage

```
docker run -p 8080:8080 -p 50000:50000 jenkins
```

NOTE: read below the _build executors_ part for the role of the `50000` port mapping.

This will store the workspace in /var/jenkins_home. All Jenkins data lives in there - including plugins and configuration.
You will probably want to make that a persistent volume (recommended):

```
docker run -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home jenkins
```

This will store the jenkins data in `/your/home` on the host.
Ensure that `/your/home` is accessible by the jenkins user in container (jenkins user - uid 1000) or use `-u some_other_user` parameter with `docker run`.


You can also use a volume container:

```
docker run --name myjenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins
```

Then myjenkins container has the volume (please do read about docker volume handling to find out more).

# Configuring logging

Jenkins logging can be configured through a properties file and `java.util.logging.config.file` Java property.
For example:

```
mkdir data
cat > data/log.properties <<EOF
handlers=java.util.logging.ConsoleHandler
jenkins.level=FINEST
java.util.logging.ConsoleHandler.level=FINEST
EOF
docker run --name myjenkins -p 8080:8080 -p 50000:50000 --env JAVA_OPTS="-Djava.util.logging.config.file=/var/jenkins_home/log.properties" -v `pwd`/data:/var/jenkins_home jenkins
```

# Plugins

Plugins are installed via

`/usr/local/bin/install-plugins.sh $(cat /plugins.txt)`

Edit the [plugins.txt](plugins.txt) in the repo to install more at build time.
