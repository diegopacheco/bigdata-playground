#!/bin/bash

cd /home/vagrant/

wget -nc https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
tar -xvf apache-hive-3.1.2-bin.tar.gz
 
export HIVE_HOME=/home/vagrant/apache-hive-3.1.2-bin/
export HADOOP_HOME=/home/vagrant/hadoop-3.3.0/

sh -c 'echo "export HIVE_HOME=\"/home/vagrant/apache-hive-3.1.2-bin/\"" >> ~/.bashrc'
sudo sh -c 'echo "export HIVE_HOME=\"/home/vagrant/apache-hive-3.1.2-bin/\"" >> /etc/profile'
sh -c 'echo "export PATH=\"$PATH:$HIVE_HOME/bin\"" >> ~/.bashrc'
sudo sh -c 'echo "export PATH=\"$PATH:$HIVE_HOME/bin\"" >> /etc/profile'

mkdir -p /home/vagrant/hive/
mkdir -p /home/vagrant/hive/warehouse/

$HADOOP_HOME/bin/hadoop fs -mkdir       /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir       /user/
$HADOOP_HOME/bin/hadoop fs -mkdir       /user/hive/
$HADOOP_HOME/bin/hadoop fs -mkdir       /user/hive/warehouse/
$HADOOP_HOME/bin/hadoop fs -chmod g+w   /tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w   /user/hive/warehouse/

rm -rf /home/vagrant/apache-hive-3.1.2-bin/lib/guava-19.0.jar
cp /home/vagrant/hadoop-3.3.0/share/hadoop/hdfs/lib/guava-27.0-jre.jar /home/vagrant/apache-hive-3.1.2-bin/lib/

echo "exit;" | $HIVE_HOME/bin/hive