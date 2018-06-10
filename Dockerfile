FROM ubuntu:xenial

MAINTAINER Jiulong Wang "jiulongw@gmail.com"

# Installing packages
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
    bc \
    bison \
    build-essential \
    curl \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf \
    git \
    gperf \
    libc6:i386 \
    libssl-dev \
    locales \
    lzop \
    python \
    sudo \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Add build user account
ENV RUN_USER linux
ENV RUN_UID 1000

RUN id $RUN_USER || adduser --uid "$RUN_UID" \
    --gecos 'Linux ARM Builder' \
    --shell '/bin/bash' \
    --disabled-login \
    --disabled-password "$RUN_USER"

# Allow user sudo without password
RUN usermod -a -G sudo $RUN_USER
RUN sed -i '/^%sudo/c%sudo ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers

# Set build environment variables
ENV ARCH arm64
ENV CROSS_COMPILE=aarch64-linux-gnu-

USER $RUN_USER
