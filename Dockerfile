FROM jsonbored/penpot-aio:2.16.0-aio.3

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		supervisor libnss-wrapper fontforge woff-tools woff2 \
	&& rm -rf /var/lib/apt/lists/*

COPY rootfs/ /

RUN chmod +x /usr/local/bin/penpot-* \
	&& sed -i 's#/appdata#/home/container/appdata#g; s#/run/penpot-aio#/tmp/penpot#g' /usr/local/bin/env-helpers.sh \
	&& sed -i '/chown mailpit:mailpit "${MAILPIT_UI_AUTH_FILE}"/d' /usr/local/bin/env-helpers.sh \
	&& chmod -R a+rX /opt/penpot /var/www/app /etc/nginx \
	&& mkdir -p /opt/penpot-aio/templates \
	&& cp /tmp/nginx.conf.template /tmp/resolvers.conf.template /opt/penpot-aio/templates/ \
	&& mv /var/www/app/js/config.js /var/www/app/js/config.js.orig \
	&& ln -s /tmp/penpot/config.js /var/www/app/js/config.js \
	&& mkdir -p /home/container/appdata /tmp/penpot

ENV PENPOT_PUBLIC_URI=http://178.63.206.185:3555
ENV PENPOT_FLAGS="disable-email-verification enable-smtp disable-secure-session-cookies"
ENV PENPOT_AIO_ENABLE_MCP=false

ENTRYPOINT ["/usr/local/bin/penpot-entrypoint"]
HEALTHCHECK NONE
