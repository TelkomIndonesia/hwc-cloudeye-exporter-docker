# syntax = docker/dockerfile:1.2


FROM golang:1.17.6 AS builder

WORKDIR /src
RUN git clone https://github.com/huaweicloud/cloudeye-exporter .
RUN git fetch --all --tags && git checkout tags/v2.0.5 -b latest
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux go build



FROM hairyhenderson/gomplate:v3.11.5-slim AS gomplate



FROM alpine:3.16
RUN apk add --no-cache ca-certificates

WORKDIR /opt/cloudeye-exporter

COPY --from=builder /src/cloudeye-exporter /bin/cloudeye-exporter
COPY --from=builder /src/metric.yml /opt/gomplate/opt/cloudeye-exporter/metric.yml
COPY --from=gomplate /gomplate /bin/gomplate
COPY ./conf /opt/gomplate/opt/cloudeye-exporter
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]