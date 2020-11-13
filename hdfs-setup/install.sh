#!/bin/bash

sudo apt-get install ssh
sudo apt-get install pdsh

sudo apt install openjdk-8-jdk
echo "JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64/bin/\" > ~/.bashrc
source ~/.bashrc

wget https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz
tar -xvf hadoop-3.3.0-aarch64.tar.gz