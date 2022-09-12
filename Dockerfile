FROM --platform=${TARGETPLATFORM} alpine:3.16 AS download
ARG TARGETOS
ARG TARGETARCH
RUN apk update
RUN apk --no-cache add ca-certificates curl
ARG GH_VERSION=2.15.0
RUN curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz" -o /tmp/gh.tar.gz && \
    tar --extract --file /tmp/gh.tar.gz --strip-components 1 --directory /tmp && rm /tmp/gh.tar.gz && \
    mv /tmp/bin/gh /usr/local/bin/gh && \
    chmod +x /usr/local/bin/gh
RUN gh --version
ARG GHAPP_VERSION=1.1.1
RUN curl -sL "https://github.com/jhagestedt/ghapp/releases/download/${GHAPP_VERSION}/ghapp_${TARGETOS}_${TARGETARCH}" -o /usr/local/bin/ghapp && \
    chmod +x /usr/local/bin/ghapp
RUN ghapp --version

FROM --platform=${TARGETPLATFORM} alpine:3.16 AS main
COPY --from=download /usr/local/bin/gh /usr/local/bin/gh
COPY --from=download /usr/local/bin/ghapp /usr/local/bin/ghapp
RUN gh version
RUN apk update
RUN apk --no-cache add bash ca-certificates curl git
ENTRYPOINT ["/usr/local/bin/gh"]
CMD ["version"]
