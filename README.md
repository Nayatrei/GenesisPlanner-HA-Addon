# GenesisPlanner Bridge — Home Assistant add-on

One-click HA add-on that connects your Home Assistant to [GenesisPlanner](https://plan.genesisframeworks.com) — no Nabu Casa, no public domain, no port forwarding.

## Install

1. Open Home Assistant → **Settings → Add-ons → ⋮ (top right) → Repositories**
2. Paste this URL: `https://github.com/Nayatrei/GenesisPlanner-HA-Addon`
3. Find **GenesisPlanner Bridge** in the add-on store, click **Install**, then **Start**
4. Click **Open Web UI** — you'll see a 6-digit pairing code
5. In the planner, go to **Settings → Home Assistant** and paste the code

You're paired. Rooms and devices appear on the planner's Home page within a few seconds.

## What it does

The add-on runs a small Node.js process on your Home Assistant host. It:

- Subscribes to HA state changes via the local WebSocket API
- Relays them to your planner session over a Firestore mailbox (end-to-end auth'd to your family only)
- Forwards planner RPCs back to HA (toggle a light, read the registry, etc.)

No tokens leave your network — HA's supervisor token is granted to the add-on automatically via `homeassistant_api: true`.

## Updating

When a new version ships, HA shows an **Update** button on the add-on's page. You can also force-check with **Settings → Add-ons → ⋮ → Check for updates**.

Release notes: [CHANGELOG](genesisplanner-bridge/CHANGELOG.md).

## Running without HA (Docker)

Households not on HA OS can run the same bridge directly:

```bash
docker run -d --name genesis-bridge --restart unless-stopped \
  -p 9123:9123 -v genesis-bridge-data:/data \
  -e HA_URL="http://YOUR.HA.IP:8123" \
  -e HA_TOKEN="<long-lived access token>" \
  ghcr.io/nayatrei/genesis-bridge:latest
```

Then visit `http://<docker-host>:9123/pair` for the code.

## Support

- Issues: [github.com/Nayatrei/GenesisPlanner-HA-Addon/issues](https://github.com/Nayatrei/GenesisPlanner-HA-Addon/issues)
- Changes to the underlying bridge live at [github.com/Nayatrei/GenesisHome/tree/main/bridge](https://github.com/Nayatrei/GenesisHome/tree/main/bridge) (this repo is a mirror of `bridge-addon/` from that monorepo).
