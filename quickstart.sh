# 将cuDNN和Anaconda安装包放进某一目录，并切换到该目录下
docker build -t deeplearning .

nvidia-docker run -it -p 22:22 --name nvidia_anaconda --gpus all deeplearning /bin/bash

# docker run -it -p 22:22 --name nvidia_anaconda --gpus all deeplearning /bin/bash

# 初始化anaconda
source activate 