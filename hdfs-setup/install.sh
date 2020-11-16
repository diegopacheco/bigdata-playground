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
sudo killall java
sudo killall java

###
### HDFS
###

cd /home/vagrant/
HADOOPBASE=/home/vagrant/hadoop-3.3.0/

wget -nc https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0-aarch64.tar.gz
tar -xvf hadoop-3.3.0-aarch64.tar.gz
#rm -rf hadoop-3.3.0-aarch64.tar.gz

cd $HADOOPBASE/
mkdir -p input/
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'
cat output/*

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
sudo sh -c 'echo "ssh" > /etc/pdsh/rcmd_default'

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> $HADOOPBASE/etc/hadoop/hadoop-env.sh
echo "export HADOOP_HOME=$HADOOPBASE" >> $HADOOPBASE/etc/hadoop/hadoop-env.sh

echo "<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>" > $HADOOPBASE/etc/hadoop/core-site.xml

echo "<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>" > $HADOOPBASE/etc/hadoop/hdfs-site.xml

bin/hdfs namenode -format
sbin/start-dfs.sh

###
### YARN
###
HADOOPBASE=/home/vagrant/hadoop-3.3.0/
cd $HADOOPBASE/

echo "<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.application.classpath</name>
        <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>
    </property>
</configuration>" > $HADOOPBASE/etc/hadoop/mapred-site.xml

echo "<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>
</configuration>" > $HADOOPBASE/etc/hadoop/yarn-site.xml

sbin/start-yarn.sh