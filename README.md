# penpot-aio-pterodactyl

Pterodactyl-compatible derivative of `jsonbored/penpot-aio:2.16.0-aio.3`.

The upstream image is a single-container Penpot stack (frontend, backend, exporter,
PostgreSQL, Redis, Mailpit). Two things make it unsuitable for Pterodactyl as-is:

- it listens on 8080, while Pterodactyl binds the allocation port inside the container;
- it stores state in `/appdata`, which is not persisted by Pterodactyl.

This image rewrites `/appdata` to `/home/container/appdata` and makes nginx listen on
`${SERVER_PORT}`. Everything else is upstream.
