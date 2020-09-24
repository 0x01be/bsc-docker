FROM 0x01be/bsc:build as build

FROM alpine

COPY --from=build /opt/iverilog/ /opt/iverilog/
COPY --from=build /opt/bsc/ /opt/bsc/

ENV PATH $PATH:/opt/iverilog/bin/:/opt/bsc/bin/

RUN apk add --no-cache --virtual bsc-runtime-dependencies \
    tcl \
    bash \
    gmp \
    libstdc++

WORKDIR /workspace

