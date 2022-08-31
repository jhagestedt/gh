FROM alpine:3.16 AS download
RUN apk update
RUN apk --no-cache add ca-certificates curl
ARG GH_VERSION=2.14.7
ARG GH_ARCHITECTURE=linux_amd64
RUN curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_${GH_ARCHITECTURE}.tar.gz" -o /tmp/gh.tar.gz && \
    tar --extract --file /tmp/gh.tar.gz --strip-components 1 --directory /tmp && rm /tmp/gh.tar.gz && \
    chmod +x /tmp/bin/gh

FROM alpine:3.16 AS main
COPY --from=download /tmp/bin/gh /usr/local/bin/gh
RUN gh version
RUN apk update
RUN apk --no-cache add bash ca-certificates curl git
ENTRYPOINT ["/usr/local/bin/gh"]
CMD ["version"]
