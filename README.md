# storm-ops
storm1.2.1 运维脚本、配置等。实现的功能包括：
1. 定制了配置目录；
2. 定制了日志存储目录；
3. 启动 nimbus 和 ui 的脚本，以及停止 nimbus 的脚本。

topology/topn 目录里是一个运行样例，也提供发布和停止脚本。

使用方法：整个目录 clone 至 ${home} 目录中，然后执行 sh storm/start.sh 启动即可。

## 安装

### 环境变量
```
JAVA_HOME=/opt/jdk
JRE_HOME=/opt/jdk/jre
STORM_HOME=/opt/storm

PATH=$PATH:$JAVA_HOME/bin
PATH=$PATH:$JRE_HOME/bin
PATH=$PATH:$STORM_HOME/bin

export PATH
```

### 依赖软件
1. storm，安装到 /opt/storm -> /opt/apache-storm-1.2.1
2. java，安装到 /opt/jdk -> /opt/jdk1.8.0_141


## 运行效果
注意进程中的配置参数，如：-Dlog4j.configurationFile 等。

### nimnus 进程
```
sgcc     12291     1  1 15:17 ?        00:01:14 java -server -Ddaemon.name=nimbus -Dstorm.options= -Dstorm.home=/opt/apache-storm-1.2.1 -Dstorm.log.dir=/home/sgcc/storm/logs -Djava.library.path=/usr/local/lib:/opt/local/lib:/usr/lib -Dstorm.conf.file=/home/sgcc/storm/conf/storm.yaml -cp /opt/apache-storm-1.2.1/*:/opt/apache-storm-1.2.1/lib/*:/opt/apache-storm-1.2.1/extlib/*:/opt/apache-storm-1.2.1/extlib-daemon/*:/home/sgcc/storm/conf -Xmx1024m -Dlogfile.name=nimbus.log -DLog4jContextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector -Dlog4j.configurationFile=/home/sgcc/storm/conf/cluster.xml org.apache.storm.daemon.nimbus
```

### supervisor 进程
```
sgcc     29950     1  0 11:34 ?        00:00:43 java -server -Ddaemon.name=supervisor -Dstorm.options= -Dstorm.home=/opt/apache-storm-1.2.1 -Dstorm.log.dir=/home/sgcc/storm/logs -Djava.library.path=/usr/local/lib:/opt/local/lib:/usr/lib -Dstorm.conf.file=/home/sgcc/storm/conf/storm.yaml -cp /opt/apache-storm-1.2.1/*:/opt/apache-storm-1.2.1/lib/*:/opt/apache-storm-1.2.1/extlib/*:/opt/apache-storm-1.2.1/extlib-daemon/*:/home/sgcc/storm/conf -Xmx256m -Dlogfile.name=supervisor.log -Dlog4j.configurationFile=/home/sgcc/storm/conf/cluster.xml org.apache.storm.daemon.supervisor.Supervisor
```

### worker
```
sgcc     15396 29950  0 16:28 ?        00:00:01 java -cp /opt/apache-storm-1.2.1/lib/*:/opt/apache-storm-1.2.1/extlib/*:/home/sgcc/storm/conf:/home/sgcc/storm/data/supervisor/stormdist/TopServer-2-1519631402/stormjar.jar -Xmx64m -Dlogging.sensitivity=S3 -Dlogfile.name=worker.log -Dstorm.home=/opt/apache-storm-1.2.1 -Dworkers.artifacts=/home/sgcc/storm/logs/workers-artifacts -Dstorm.id=TopServer-2-1519631402 -Dworker.id=1f2395b2-e9d9-4260-a200-acb0759fd03b -Dworker.port=6701 -Dstorm.log.dir=/home/sgcc/storm/logs -Dlog4j.configurationFile=/home/sgcc/storm/conf/worker.xml -DLog4jContextSelector=org.apache.logging.log4j.core.selector.BasicContextSelector -Dstorm.local.dir=/home/sgcc/storm/data org.apache.storm.LogWriter java -server -Dlogging.sensitivity=S3 -Dlogfile.name=worker.log -Dstorm.home=/opt/apache-storm-1.2.1 -Dworkers.artifacts=/home/sgcc/storm/logs/workers-artifacts -Dstorm.id=TopServer-2-1519631402 -Dworker.id=1f2395b2-e9d9-4260-a200-acb0759fd03b -Dworker.port=6701 -Dstorm.log.dir=/home/sgcc/storm/logs -Dlog4j.configurationFile=/home/sgcc/storm/conf/worker.xml -DLog4jContextSelector=org.apache.logging.log4j.core.selector.BasicContextSelector -Dstorm.local.dir=/home/sgcc/storm/data -Xmx768m -XX:+PrintGCDetails -Xloggc:artifacts/gc.log -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=1M -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=artifacts/heapdump -Djava.library.path=/home/sgcc/storm/data/supervisor/stormdist/TopServer-2-1519631402/resources/Linux-amd64:/home/sgcc/storm/data/supervisor/stormdist/TopServer-2-1519631402/resources:/usr/local/lib:/opt/local/lib:/usr/lib -Dstorm.conf.file=/home/sgcc/storm/conf/storm.yaml -Dstorm.options= -Djava.io.tmpdir=/home/sgcc/storm/data/workers/1f2395b2-e9d9-4260-a200-acb0759fd03b/tmp -cp /opt/apache-storm-1.2.1/lib/*:/opt/apache-storm-1.2.1/extlib/*:/home/sgcc/storm/conf:/home/sgcc/storm/data/supervisor/stormdist/TopServer-2-1519631402/stormjar.jar org.apache.storm.daemon.worker TopServer-2-1519631402 df1415a8-b4b4-45fb-8a86-584c774cb55f 6701 1f2395b2-e9d9-4260-a200-acb0759fd03b
```


## 踩坑
1. storm 集群的机器必须在 host 绑定。vim /etc/hosts 中增加集群中所有的机器名和IP绑定即可。
2. 日志查看和 jstorm 不一样，根据配置目录中的 log4j2 配置对应的去查看。
