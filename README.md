# penpot-aio-pterodactyl

Pterodactyl-compatible derivative of `jsonbored/penpot-aio:2.16.0-aio.3`.

The upstream image is a single-container Penpot stack (frontend, backend, exporter,
PostgreSQL, Redis, Mailpit), but it assumes it runs as root and writes to `/appdata`.
Pterodactyl runs server containers as an unprivileged system user and only persists
`/home/container`.

This image replaces the s6 init with supervisord, runs every service as the container
user, stores all state in `/home/container/appdata`, and makes nginx listen on
`${SERVER_PORT}`. A generated passwd shim (`libnss-wrapper`) lets PostgreSQL initialize
under whatever UID Wings assigns.
