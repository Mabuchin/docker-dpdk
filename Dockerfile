FROM ubuntu:16.04

ENV DPDK_VERSION=17.11.4

RUN apt-get update -y \
    && apt-get install -y -q wget curl cmake build-essential linux-headers-$(uname -r) \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://fast.dpdk.org/rel/dpdk-$DPDK_VER.tar.xz \
       && tar -xf dpdk-${DPDK_VERSION}.tar.xz -C /usr/local/src \
       && rm dpdk-${DPDK_VERSION}.tar.xz

ENV RTE_TARGET x86_64-native-linuxapp-gcc
ENV RTE_SDK /usr/local/src/dpdk-${DPDK_VERSION}

WORKDIR $RTE_SDK
RUN make install T=${RTE_TARGET}

