# hadoop-docker
容器化本机部署 hadoop 集群

# 运行

建议先下载 http://archive.apache.org/dist/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz 放到项目根目录
注释 `Dockerfile` 中的 wget 命令，转而启用复制。

```bash
# 创建镜像
docker build -t hadoop_ubuntu:1.0 .

# 创建网络
docker network create --driver=bridge hadoop

# 创建节点
docker run  -itd --network hadoop -h "master" --name "master" -p 9870:9870 -p 8088:8088 hadoop_ubuntu:1.0
docker run  -itd --network hadoop -h "slave1" --name "slave1" hadoop_ubuntu:1.0
docker run  -itd --network hadoop -h "slave2" --name "slave2" hadoop_ubuntu:1.0

#进入 master 节点启动集群
docker exec -it master bash
/usr/local/hadoop/sbin/start-all.sh
```