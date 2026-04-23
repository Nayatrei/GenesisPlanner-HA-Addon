#!/bin/sh
# Map HA add-on config (and supervisor-issued auth) onto the env vars
# the bridge already expects. Keeps the bridge container itself
# unaware of "I'm running inside HA Supervisor."
set -e

OPTIONS_FILE="${OPTIONS_FILE:-/data/options.json}"

USER_HA_URL=""
USER_HA_TOKEN=""
if [ -f "$OPTIONS_FILE" ]; then
  USER_HA_URL="$(jq -r '.ha_url // ""' "$OPTIONS_FILE")"
  USER_HA_TOKEN="$(jq -r '.ha_token // ""' "$OPTIONS_FILE")"
fi

# Default to the supervisor proxy. Power users can point the add-on at
# a different HA by setting ha_url in the add-on config.
if [ -n "$USER_HA_URL" ]; then
  export HA_URL="$USER_HA_URL"
else
  export HA_URL="http://supervisor/core"
fi

# Prefer a user-supplied LLAT only when they've overridden ha_url to a
# different HA (the supervisor token won't authorize against another
# instance). Otherwise the supervisor token is the right choice — it's
# rotated by HA itself, scoped to this add-on, and the user never has
# to create or paste anything.
if [ -n "$USER_HA_TOKEN" ]; then
  export HA_TOKEN="$USER_HA_TOKEN"
elif [ -n "$SUPERVISOR_TOKEN" ]; then
  export HA_TOKEN="$SUPERVISOR_TOKEN"
else
  echo "ERROR: no HA_TOKEN provided and SUPERVISOR_TOKEN missing — cannot talk to HA" >&2
  exit 1
fi

# Bridge state lives in the add-on's persisted config dir.
export BRIDGE_DATA_DIR="${BRIDGE_DATA_DIR:-/data}"

exec node /app/src/index.js
