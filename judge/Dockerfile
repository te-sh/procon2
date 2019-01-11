FROM python:3.7.2-slim-stretch

ENV HOME=/root
ENV DLANG=$HOME/dlang

WORKDIR $HOME

RUN pip install online-judge-tools

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      inotify-tools \
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

RUN $DLANG/install.sh dmd-2.083.0 \
 && rm -rf \
      $DLANG/dmd-2.083.0/linux/bin32 \
      $DLANG/dmd-2.083.0/linux/lib32 \
      $DLANG/dmd-2.083.0/freebsd \
      $DLANG/dmd-2.083.0/osx \
      $DLANG/dmd-2.083.0/solaris \
      $DLANG/dmd-2.083.0/windows \
      $DLANG/dmd-2.083.0/html \
      $DLANG/dmd-2.083.0/man \
      $DLANG/dmd-2.083.0/samples

RUN $DLANG/install.sh dmd-2.083.1 \
 && rm -rf \
      $DLANG/dmd-2.083.1/linux/bin64 \
      $DLANG/dmd-2.083.1/linux/lib64 \
      $DLANG/dmd-2.083.1/freebsd \
      $DLANG/dmd-2.083.1/osx \
      $DLANG/dmd-2.083.1/solaris \
      $DLANG/dmd-2.083.1/windows \
      $DLANG/dmd-2.083.1/html \
      $DLANG/dmd-2.083.1/man \
      $DLANG/dmd-2.083.1/samples

ENV PATH=$DLANG/dmd-2.083.0/linux/bin64:$PATH
ENV LIBRARY_PATH=$DLANG/dmd-2.083.0/linux/lib64:$LIBRARY_PATH
ENV LD_LIBRARY_PATH=$DLANG/dmd-2.083.0/linux/lib64:$LIBRARY_PATH

COPY runoj.d config.json start-monitor ./
RUN dmd -of=runoj runoj.d

ENTRYPOINT ["./start-monitor"]
