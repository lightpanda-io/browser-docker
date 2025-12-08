FROM docker.io/debian:stable-slim AS tini

RUN apt-get update -yq && \
    apt-get install -yq tini

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

COPY --from=tini /usr/bin/tini /usr/bin/tini

RUN groupadd -r lightpanda && useradd -rm -g lightpanda lightpanda

USER lightpanda

EXPOSE 9222/tcp

# Lightpanda install only some signal handlers, and PID 1 doesn't have a default SIGTERM signal handler.
# Using "tini" as PID1 ensures that signals work as expected, so e.g. "docker stop" will not hang.
# (See https://github.com/krallin/tini#why-tini).
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/lightpanda", "serve", "--host", "0.0.0.0", "--port", "9222", "--log_level", "info"]
STOPSIGNAL SIGKILL
