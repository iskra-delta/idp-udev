FROM debian:bookworm-slim

ARG Z80PACK_REF=91fd28eb04e675c2127df88ed3f40675e15282e2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        cpmtools \
        git \
        sdcc \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/udo-munk/z80pack.git /opt/z80pack \
    && cd /opt/z80pack \
    && git checkout "$Z80PACK_REF" \
    && make -C cpmsim/srcsim \
    && make -C cpmsim/srctools

WORKDIR /work
