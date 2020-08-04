hadoop-2.7.1/etc/hadoop/core-site.xml
```
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

hadoop-2.7.1/etc/hadoop/mapred-site.xml
```
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

hadoop-2.7.1/etc/hadoop/hdfs-site.xml
```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/hadoop-2.7.1/data/namenode</value>
    </property>
    
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/hadoop-2.7.1/data/datanode</value>
    </property>
    
    <property>
        <name>dfs.namenode.http-address</name>
        <value>localhost:50070</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>localhost:50090</value>
    </property>
    
    <property>
        <name>dfs.namenode.checkpoint.dir</name>
        <value>/hadoop-2.7.1/data/namesecondary</value>
    </property>
    
    <property>
        <name>dfs.webhdfs.enabled</name>
        <value>true</value>
    </property>
</configuration>
```

hadoop-2.7.1/etc/hadoop/yarn-site.xml
```
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>

    <property>
        <name>yarn.nodemanager.local-dirs</name>
        <value>/hadoop-2.7.1/data/tmp</value>
    </property>
</configuration>
```

hadoop-2.7.1/etc/hadoop/hadoop-env.cmd
```
set JAVA_HOME=C:\PROGRA~1\Java\jdk1.8.0_251
```

hadoop-2.7.1\sbin\start-dfs.cmd
```
start "Apache Hadoop Distribution" hadoop secondarynamenode
```

hadoop-2.7.1\sbin\stop-dfs.cmd
```
Taskkill /FI "WINDOWTITLE eq Apache Hadoop Distribution - hadoop   secondarynamenode"
```