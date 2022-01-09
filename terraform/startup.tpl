#!/bin/bash

echo "TARGET_ENDPOINT = ${endpoint}" > /tmp/iplist

sudo apt-get -y install default-jdk
java -version

java -jar /tmp/benchmark-client.jar %* > log.txt