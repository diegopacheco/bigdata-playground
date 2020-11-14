#!/bin/bash

sudo apt-get install ssh -y
sudo apt-get install pdsh -y

sudo apt install openjdk-8-jdk -y
echo "JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64/\"" > ~/.bashrc
echo "PATH=$PATH:$JAVA_HOME/bin" > ~/.bashrc
source ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin

java -version

wget -nc https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz
tar -xvf hadoop-3.3.0-aarch64.tar.gz
cd hadoop-3.3.0/
mkdir -p input/
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'
cat output/*

