# Thin HA add-on wrapper around our published bridge image. Supervisor
# builds this on the user's HA host on first install — no separate
# per-arch publish needed.
ARG BUILD_FROM=ghcr.io/nayatrei/genesis-bridge:latest
FROM ${BUILD_FROM}

# jq parses /data/options.json (HA writes the user's add-on config there).
# Alpine doesn't ship it by default.
RUN apk add --no-cache jq

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
