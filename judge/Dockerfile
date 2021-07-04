FROM python:3.9.5-slim-buster

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
ENV NIMBLE=$HOME/.nimble

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
      ca-certificates \
      curl \
      dumb-init \
      gcc \
      gcc-multilib \
      gnupg \
      inotify-tools \
      libc6-dev \
      libgmp-dev \
      time \
      wget \
      xz-utils \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p $DLANG \
 && wget https://dlang.org/install.sh -O $DLANG/install.sh \
 && chmod a+x $DLANG/install.sh \
 && $DLANG/install.sh $DMD_ATCODER \
 && $DLANG/install.sh $DMD_YUKICODER \
 && $DLANG/install.sh $DMD_CODEFORCES

RUN curl -sSL https://dist.crystal-lang.org/apt/setup.sh | bash \
 && curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add - \
 && echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends crystal \
 && apt-get clean \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN curl https://nim-lang.org/choosenim/init.sh -sSf | sh -s - -y

RUN pip install watchdog online-judge-tools

COPY runoj.py monitor-code.sh oj-download dmd-compile nim-compile oj-test oj-test-crystal ./

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["./runoj.py"]
