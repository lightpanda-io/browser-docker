FROM docker.io/debian:stable-slim AS builder

ARG TARGETPLATFORM

LABEL maintainer="Pierre Tachoire <pierre@lightpanda.io>"

RUN set -x \
    && apt-get update \
    && apt-get install -y curl ca-certificates

# Install latest lightpanda nightly build
RUN case $TARGETPLATFORM in \
    "linux/arm64") ARCH="aarch64" ;; \
    *) ARCH="x86_64" ;; \
    esac && \
    curl --fail -L -o /lightpanda \
    https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-${ARCH}-linux && \
    chmod a+x /lightpanda

FROM docker.io/debian:stable-slim

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /lightpanda /bin/lightpanda

RUN groupadd -r lightpanda && useradd -rm -g lightpanda lightpanda

USER lightpanda

EXPOSE 9222/tcp

ENTRYPOINT ["lightpanda", "serve", "--host", "0.0.0.0", "--port", "9222"]
STOPSIGNAL SIGKILL
