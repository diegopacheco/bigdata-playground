#!/bin/bash

sudo apt-get install ssh -y
sudo apt-get install pdsh -y

sudo apt install openjdk-8-jdk -y
sh -c 'echo "export JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64/\"" >> ~/.bashrc'
sh -c 'echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.bashrc'
sudo sh -c 'echo "export JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64/\"" >> /etc/profile'
sudo sh -c 'echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile'
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin

java -version

cd /home/vagrant/

wget -nc https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz
tar -xvf hadoop-3.3.0-aarch64.tar.gz
rm -rf hadoop-3.3.0-aarch64.tar.gz
cd hadoop-3.3.0/
mkdir -p input/
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'
cat output/*

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

sudo sh -c 'echo "ssh" > /etc/pdsh/rcmd_default'
#ssh -o StrictHostKeyChecking=no localhost

bin/hdfs namenode -format
sbin/start-dfs.sh
