FROM alpine:3.16

RUN apk update
RUN apk --no-cache add bash ca-certificates curl git

ARG GH_VERSION=2.14.7
ARG GH_ARCHITECTURE=linux_amd64
RUN curl -L "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_${GH_ARCHITECTURE}.tar.gz" -o /tmp/gh.tar.gz && \
    mkdir -p /tmp/gh && \
    tar --extract --file /tmp/gh.tar.gz --strip-components 1 --directory /tmp/gh && rm /tmp/gh.tar.gz && \
    cp /tmp/gh/bin/gh /usr/local/bin/gh && chmod +x /usr/local/bin/gh
RUN gh version

WORKDIR /work
ENTRYPOINT ["/usr/local/bin/gh"]
CMD ["version"]
