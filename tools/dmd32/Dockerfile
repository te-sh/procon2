FROM i386/ubuntu:16.04

RUN apt-get update \
 && apt-get install -y build-essential libcurl3 wget \
 && wget http://downloads.dlang.org/releases/2017/dmd_2.074.1-0_i386.deb \
 && dpkg -i dmd_2.074.1-0_i386.deb \
 && rm dmd_2.074.1-0_i386.deb
