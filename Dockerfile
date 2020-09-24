FROM 0x01be/iverilog as iverilog

FROM 0x01be/haskell as builder

COPY --from=iverilog /opt/iverilog/ /opt/iverilog/

ENV PATH $PATH:/opt/iverilog/bin/

RUN apk add --no-cache --virtual bsc-build-dependencies \
    git \
    build-base \
    autoconf \
    ccache \
    bison \
    flex \
    gperf \
    tcl-dev \
    wget \
    bash

RUN cabal v1-install old-time regex-compat syb split

ENV BSC_REVISION master
RUN git clone --recursive --branch ${BSC_REVISION} https://github.com/B-Lang-org/bsc.git /bsc

COPY 0001-Disable-fpu_control.patch /bsc/

WORKDIR /bsc
RUN patch -p0 < 0001-Disable-fpu_control.patch

RUN make install

