FROM openjdk:8
MAINTAINER wangdj2020 <wangdongjie2020@gmail.com>

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y vim sudo net-tools inetutils-ping dnsutils maven scala openssh-server openssh-client rsync

RUN wget -P /usr/local http://archive.apache.org/dist/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz

#COPY ./hadoop-3.1.3.tar.gz /usr/local/hadoop-3.1.3.tar.gz
RUN tar -zxvf /usr/local/hadoop-3.1.3.tar.gz && \
    mv hadoop-3.1.3 /usr/local/hadoop && \
    rm /usr/local/hadoop-3.1.3.tar.gz

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


COPY ./conf/bashrc /root/.bashrc
COPY ./conf/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
COPY ./conf/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh
COPY ./conf/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml
COPY ./conf/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
COPY ./conf/workers /usr/local/hadoop/etc/hadoop/workers
COPY ./conf/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]