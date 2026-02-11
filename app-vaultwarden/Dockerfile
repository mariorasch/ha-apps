ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian

FROM "vaultwarden/server:1.35.3" AS vaultwarden

FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Vaultwarden dependencies libmariadb3, libpq5 and sqlite3.
#
# Remove lists directory for smaller image size and
# remove /etc/nginx after installation so that it does
# not interfere with configuration copied from rootfs.

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    libmariadb3 \
    libpq5 \
    nginx \
    sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/nginx

COPY rootfs /
COPY --from=vaultwarden /vaultwarden /opt/vaultwarden
COPY --from=vaultwarden /web-vault /opt/web-vault

ARG BUILD_NAME=Vaultwarden
ARG BUILD_DESCRIPTION="Vaultwarden - password management app for Home Assistant"
ARG BUILD_ARCH=aarch64
ARG BUILD_REPOSITORY=mariorasch/ha-apps
ARG BUILD_DATE
ARG BUILD_REV=1
ARG BUILD_VERSION=1.0.24

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Mario Rasch <mario.rasch@web.de>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Apps by Mario Rasch" \
    org.opencontainers.image.authors="Mario Rasch <mario.rasch@web.de>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://ghcr.io/mariorasch/ha-apps/app-vaultwarden" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/app-vaultwarden/DOCS.md" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${BUILD_REV}" \
    org.opencontainers.image.version="${BUILD_VERSION}"
