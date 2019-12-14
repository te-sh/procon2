FROM debian:buster-slim as build

ENV HOME=/root
ENV DLANG=$HOME/dlang

WORKDIR $HOME

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gcc \
      gnupg \
      libc6-dev \
      wget \
      xz-utils \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p $DLANG \
 && wget https://dlang.org/install.sh -O $DLANG/install.sh \
 && chmod a+x $DLANG/install.sh

RUN $DLANG/install.sh dmd-2.070.1 \
 && rm -rf \
      $DLANG/dmd-2.070.1/linux/bin32 \
      $DLANG/dmd-2.070.1/linux/lib32 \
      $DLANG/dmd-2.070.1/freebsd \
      $DLANG/dmd-2.070.1/osx \
      $DLANG/dmd-2.070.1/solaris \
      $DLANG/dmd-2.070.1/windows \
      $DLANG/dmd-2.070.1/html \
      $DLANG/dmd-2.070.1/man \
      $DLANG/dmd-2.070.1/samples

RUN $DLANG/install.sh dmd-2.088.0 \
 && rm -rf \
      $DLANG/dmd-2.088.0/linux/bin32 \
      $DLANG/dmd-2.088.0/linux/lib32 \
      $DLANG/dmd-2.088.0/freebsd \
      $DLANG/dmd-2.088.0/osx \
      $DLANG/dmd-2.088.0/solaris \
      $DLANG/dmd-2.088.0/windows \
      $DLANG/dmd-2.088.0/html \
      $DLANG/dmd-2.088.0/man \
      $DLANG/dmd-2.088.0/samples

RUN $DLANG/install.sh dmd-2.086.0 \
 && rm -rf \
      $DLANG/dmd-2.086.0/linux/bin32 \
      $DLANG/dmd-2.086.0/linux/lib64 \
      $DLANG/dmd-2.086.0/freebsd \
      $DLANG/dmd-2.086.0/osx \
      $DLANG/dmd-2.086.0/solaris \
      $DLANG/dmd-2.086.0/windows \
      $DLANG/dmd-2.086.0/html \
      $DLANG/dmd-2.086.0/man \
      $DLANG/dmd-2.086.0/samples

COPY runoj.d config.json start-monitor ./
RUN PATH=$DLANG/dmd-2.088.0/linux/bin64:$PATH \
    LIBRARY_PATH=$DLANG/dmd-2.088.0/linux/lib64:$LIBRARY_PATH \
    LD_LIBRARY_PATH=$DLANG/dmd-2.088.0/linux/lib64:$LIBRARY_PATH \
    dmd -of=runoj -defaultlib=libphobos2.a runoj.d

FROM python:3.8.0-slim-buster

ENV HOME=/root
ENV DLANG=$HOME/dlang

WORKDIR $HOME

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      gcc \
      gcc-multilib \
      inotify-tools \
      libgmp-dev \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN pip install online-judge-tools

COPY --from=build $HOME/dlang dlang
COPY --from=build $HOME/runoj runoj
COPY config.json start-monitor ./

ENTRYPOINT ["./start-monitor"]
