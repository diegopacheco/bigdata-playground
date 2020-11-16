#!/bin/bash

##
## Scala 
##

wget -nc https://downloads.lightbend.com/scala/2.13.3/scala-2.13.3.tgz
tar -xvf scala-2.13.3.tgz
mv scala-2.13.3/ /home/vagrant/

export SCALA_HOME=/home/vagrant/scala-2.13.3/
export PATH=$PATH:$SCALA_HOME/bin

sh -c 'echo "export SCALA_HOME=\"/home/vagrant/scala-2.13.3/\"" >> ~/.bashrc'
sh -c 'echo "export PATH=$PATH:$SCALA_HOME/bin" >> ~/.bashrc'
sudo sh -c 'echo "export SCALA_HOME=\"/home/vagrant/scala-2.13.3/\"" >> /etc/profile'
sudo sh -c 'echo "export PATH=$PATH:$SCALA_HOME/bin" >> /etc/profile'

scala -version

##
## Spark
##

wget -nc https://www.apache.org/dyn/closer.lua/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz
tar -xvf spark-3.0.1-bin-hadoop3.2.tgz
mv spark-3.0.1-bin-hadoop3.2/ /home/vagrant/ 

export SPARK_HOME=/home/vagrant/spark-3.0.1-bin-hadoop3.2/
