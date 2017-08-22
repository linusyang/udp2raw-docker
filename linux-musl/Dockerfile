FROM privatelo/cross-multi:latest
ARG REV=master
ADD linux-musl /build
RUN \
  chmod 755 /build/build.sh && \
  /bin/bash -c /build/build.sh
