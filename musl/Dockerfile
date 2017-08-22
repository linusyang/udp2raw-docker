FROM privatelo/cross-multi:latest
ARG REV=master
ADD musl /build
RUN \
  chmod 755 /build/build.sh && \
  /bin/bash -c /build/build.sh
