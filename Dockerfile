FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

WORKDIR /root

# 安装cudnn
ADD cudnn-linux-x86_64-8.9.5.30_cuda11-archive.tar.xz /root
RUN cp /root/cudnn-linux-x86_64-8.9.5.30_cuda11-archive/include/* /usr/local/cuda/include/ \
    && cp /root/cudnn-linux-x86_64-8.9.5.30_cuda11-archive/lib/* /usr/local/cuda/lib64/ \
    && rm -rf /root/cudnn-linux-x86_64-8.9.5.30_cuda11-archive.tar.xz

# 安装anaconda
ADD Anaconda3-2022.10-Linux-x86_64.sh /root
RUN bash /root/Anaconda3-2022.10-Linux-x86_64.sh -b -p /root/anaconda3 \
    && echo 'export PATH=$PATH:/root/anaconda3/bin' >>/root/.bashrc \
    && /bin/bash -c "source /root/.bashrc" \
    && rm -rf /root/Anaconda3-2022.10-Linux-x86_64.sh \
ENV PATH $PATH:/root/anaconda3/bin

# 安装vim、g++/gcc
RUN apt update \
    && apt install vim -y \
    && apt install build-essential -y

# 安装配置ssh
RUN apt update \
    && apt install openssh-server -y \
    && mkdir -p /var/run/sshd \
    && mkdir -p /root/.ssh
ADD run.sh /root
RUN chmod +x /root/run.sh

# 开放22端口
EXPOSE 22

# 设置脚本自启动
ENTRYPOINT ["/root/run.sh"]