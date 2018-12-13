FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y ant autoconf git g++-multilib libtool make nasm python3-pip python-pip subversion unzip wget zip bsdtar

RUN wget -q -O - https://cmake.org/files/v3.8/cmake-3.8.1-Linux-x86_64.tar.gz | tar zxf - -C /opt
RUN mkdir /opt/ninja; cd /opt/ninja; wget -q https://github.com/ninja-build/ninja/releases/download/v1.7.2/ninja-linux.zip; unzip ninja-linux.zip; rm ninja-linux.zip
ENV PATH="${PATH}:/opt/cmake-3.8.1-Linux-x86_64/bin:/opt/ninja"

RUN cd /opt && git clone https://github.com/juj/emsdk.git && cd emsdk && ./emsdk install latest && ./emsdk activate latest
RUN echo "source /opt/emsdk/emsdk_env.sh" >> /etc/profile && echo "source /etc/profile" > /root/.bashrc && echo "source /etc/profile" > /root/.bash_profile && echo "source /etc/profile" > /root/.profile
RUN touch /etc/profile

ENV BASH_ENV "/root/.bashrc"
ENV PATH="${PATH}:/opt/emsdk"
ENV EMSDK=/opt/emsdk
ENV EM_CONFIG=/root/.emscripten
ENV LLVM_ROOT=/opt/emsdk/clang/e1.38.21_64bit
ENV EMSCRIPTEN_NATIVE_OPTIMIZER=/opt/emsdk/clang/e1.38.21_64bit/optimizer
ENV BINARYEN_ROOT=/opt/emsdk/clang/e1.38.21_64bit/binaryen
ENV EMSDK_NODE=/opt/emsdk/node/8.9.1_64bit/bin/node
ENV EMSCRIPTEN=/opt/emsdk/emscripten/1.38.21
WORKDIR "/root/workdir"
