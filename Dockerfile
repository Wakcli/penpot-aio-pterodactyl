FROM jsonbored/penpot-aio:2.16.0-aio.3

USER root
COPY patch.sh /tmp/patch.sh
RUN bash /tmp/patch.sh && rm /tmp/patch.sh

ENV PENPOT_AIO_ENABLE_MCP=false

HEALTHCHECK NONE
