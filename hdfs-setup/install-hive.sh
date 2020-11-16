#!/bin/bash

wget -nc https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
tar -xvf apache-hive-3.1.2-bin.tar.gz
mv apache-hive-3.1.2-bin/ /home/vagrant/
export HIVE_HOME=/home/vagrant/apache-hive-3.1.2-bin/