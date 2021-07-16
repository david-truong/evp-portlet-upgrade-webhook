#!/bin/bash

git branch | grep "lugbot_" | xargs git branch -D

REPO_PATH=$(pwd)

docker run \
	--rm \
	-it \
	-v "${REPO_PATH}":/repo \
	-e WEBHOOK_JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000" \
	-e UPGRADE_JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5000" \
	-p 5000:5000/tcp \
	-p 8000:8000/tcp \
	-p 9000:9000/tcp \
	-p 9001:9001/tcp \
	lugbot/lugbot:latest \
	$@