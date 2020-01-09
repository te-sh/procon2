FROM debian:buster-slim as build

ENV HOME=/root
ENV DLANG=$HOME/dlang

WORKDIR $HOME

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gnupg \
      libc6-dev \
      wget \
      xz-utils \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ARG DMD_ATCODER
ARG DMD_UNUSED_ATCODER
ARG DMD_YUKICODER
ARG DMD_UNUSED_YUKICODER
ARG DMD_CODEFORCES
ARG DMD_UNUSED_CODEFORCES

RUN mkdir -p $DLANG \
 && wget https://dlang.org/install.sh -O $DLANG/install.sh \
 && chmod a+x $DLANG/install.sh

RUN $DLANG/install.sh $DMD_ATCODER \
 && for dir in $DMD_UNUSED_ATCODER; do rm -rf $DLANG/$DMD_ATCODER/$dir; done \
 && $DLANG/install.sh $DMD_YUKICODER \
 && for dir in $DMD_UNUSED_YUKICODER; do rm -rf $DLANG/$DMD_YUKICODER/$dir; done \
 && $DLANG/install.sh $DMD_CODEFORCES \
 && for dir in $DMD_UNUSED_CODEFORCES; do rm -rf $DLANG/$DMD_CODEFORCES/$dir; done

FROM python:3.8.1-slim-buster

ARG SITES
ARG DMD_ATCODER
ARG DMD_BINDIR_ATCODER
ARG DMD_LIBDIR_ATCODER
ARG DMD_OPTION_ATCODER
ARG DMD_YUKICODER
ARG DMD_BINDIR_YUKICODER
ARG DMD_LIBDIR_YUKICODER
ARG DMD_OPTION_YUKICODER
ARG DMD_CODEFORCES
ARG DMD_BINDIR_CODEFORCES
ARG DMD_LIBDIR_CODEFORCES
ARG DMD_OPTION_CODEFORCES

ENV HOME=/root
ENV DLANG=$HOME/dlang

ENV SITES=$SITES
ENV DMD_ATCODER=$DMD_ATCODER
ENV DMD_BINDIR_ATCODER=$DMD_BINDIR_ATCODER
ENV DMD_LIBDIR_ATCODER=$DMD_LIBDIR_ATCODER
ENV DMD_OPTION_ATCODER=$DMD_OPTION_ATCODER
ENV DMD_YUKICODER=$DMD_YUKICODER
ENV DMD_BINDIR_YUKICODER=$DMD_BINDIR_YUKICODER
ENV DMD_LIBDIR_YUKICODER=$DMD_LIBDIR_YUKICODER
ENV DMD_OPTION_YUKICODER=$DMD_OPTION_YUKICODER
ENV DMD_CODEFORCES=$DMD_CODEFORCES
ENV DMD_BINDIR_CODEFORCES=$DMD_BINDIR_CODEFORCES
ENV DMD_LIBDIR_CODEFORCES=$DMD_LIBDIR_CODEFORCES
ENV DMD_OPTION_CODEFORCES=$DMD_OPTION_CODEFORCES

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
COPY runoj.d start-monitor oj-download dmd-compile oj-test ./
RUN PATH=$DLANG/$DMD_YUKICODER/$DMD_BINDIR_YUKICODER:$PATH \
    LIBRARY_PATH=$DLANG/$DMD_YUKICODER/$DMD_LIBDIR_YUKICODER:$LIBRARY_PATH \
    LD_LIBRARY_PATH=$DLANG/$DMD_YUKICODER/$DMD_LIBDIR_YUKICODER:$LD_LIBRARY_PATH \
    dmd -O -release -inline -of=runoj runoj.d

ENTRYPOINT ["./start-monitor"]
