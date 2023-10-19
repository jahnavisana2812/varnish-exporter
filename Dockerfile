FROM golang:1.16 as exporter

ARG VARNISH_PROMETHEUS_EXPORTER_VSN=1.6.1

RUN go install github.com/jonnenauha/prometheus_varnish_exporter@$VARNISH_PROMETHEUS_EXPORTER_VSN

FROM varnish:7.3

EXPOSE 9131
VOLUME /var/lib/varnish
ENTRYPOINT ["/usr/local/bin/prometheus_varnish_exporter"]
COPY --from=exporter /go/bin/prometheus_varnish_exporter /usr/local/bin
LABEL org.opencontainers.image.title="prometheus-varnish-exporter"
LABEL org.opencontainers.image.source="https://github.com/TomekGl/prometheus-varnish-exporter"
LABEL org.opencontainers.image.url="https://github.com/jonnenauha/prometheus_varnish_exporter"
LABEL org.opencontainers.image.revision="$VARNISH_PROMETHEUS_EXPORTER_VSN"