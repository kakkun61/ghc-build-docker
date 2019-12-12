FROM ubuntu:18.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8

ENV PATH /root/.ghcup/bin:/root/.cabal/bin:$PATH

# Preparation
# -----------
#   [1]: https://ghc.haskell.org/trac/ghc/wiki/Building/Preparation/Linux
#
RUN apt-get update && \
    apt-get -y install git autoconf automake libtool make gcc g++ libgmp-dev ncurses-dev libtinfo-dev python3 xz-utils curl apt-utils

RUN mkdir -p /root/.ghcup/bin && \
    curl -Ssf https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > /root/.ghcup/bin/ghcup && \
    chmod +x /root/.ghcup/bin/ghcup

RUN ghcup install 8.6.5 && \
    ghcup set 8.6.5

RUN ghcup install-cabal 3.0.0.0 && \
    cabal update

# for the build with make
RUN cabal install -j alex happy

# docker build -t build_ghc .
# docker run -it -v "${GHC_DIR}:/ghc" build_ghc /bin/bash
# cp -R /ghc /work
# cd /work
# hadrian/build.sh -j --configure
# # or
# ./boot && ./configure && ./make -j
