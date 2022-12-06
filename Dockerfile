FROM --platform=${TARGETPLATFORM} alpine:3.17 AS download
ARG TARGETOS
ARG TARGETARCH
RUN apk update
RUN apk --no-cache add ca-certificates curl
ARG GH_VERSION=2.17.0
RUN curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz" -o /tmp/gh.tar.gz && \
    tar --extract --file /tmp/gh.tar.gz --strip-components 1 --directory /tmp && rm /tmp/gh.tar.gz && \
    mv /tmp/bin/gh /usr/local/bin/gh && \
    chmod +x /usr/local/bin/gh
ARG GHAPP_VERSION=1.1.3
RUN curl -sL "https://github.com/jhagestedt/ghapp/releases/download/${GHAPP_VERSION}/ghapp_${TARGETOS}_${TARGETARCH}" -o /usr/local/bin/ghapp && \
    chmod +x /usr/local/bin/ghapp
ARG CURLIE_VERSION=1.6.9
RUN curl -sL "https://github.com/rs/curlie/releases/download/v${CURLIE_VERSION}/curlie_${CURLIE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz" -o /tmp/curlie.tar.gz && \
    tar --extract --file /tmp/curlie.tar.gz --directory /tmp && rm /tmp/curlie.tar.gz && \
    mv /tmp/curlie /usr/local/bin/curlie && \
    chmod +x /usr/local/bin/curlie

FROM --platform=${TARGETPLATFORM} alpine:3.17 AS main
COPY --from=download /usr/local/bin/gh /usr/local/bin/gh
COPY --from=download /usr/local/bin/ghapp /usr/local/bin/ghapp
COPY --from=download /usr/local/bin/curlie /usr/local/bin/curlie
RUN gh --version
RUN ghapp --version
RUN apk update
RUN apk --no-cache add bash ca-certificates curl git httpie
ENTRYPOINT ["/usr/local/bin/gh"]
CMD ["version"]
