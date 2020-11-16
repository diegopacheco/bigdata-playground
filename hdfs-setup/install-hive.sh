#!/bin/bash

cd /home/vagrant/

wget -nc https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
tar -xvf apache-hive-3.1.2-bin.tar.gz
 
export HIVE_HOME=/home/vagrant/apache-hive-3.1.2-bin/

sh -c 'echo "export HIVE_HOME=\"/home/vagrant/apache-hive-3.1.2-bin/\"" >> ~/.bashrc'
sudo sh -c 'echo "export HIVE_HOME=\"/home/vagrant/apache-hive-3.1.2-bin/\"" >> /etc/profile'

