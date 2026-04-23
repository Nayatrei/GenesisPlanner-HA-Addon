# Changelog

## 0.1.2

- **Fix:** Home page was showing "Bridge did not respond" even when the bridge was paired and heartbeating. Root cause: Firestore rejects nested arrays, and Home Assistant's device registry returns `connections` and `identifiers` as arrays of 2-tuples — every response write crashed. Bridge responses and push envelopes now carry JSON-encoded payloads so arbitrary HA data shapes round-trip safely.
- Browser side reads both the new `resultJson` / `payloadJson` shape and the legacy raw fields, so updating the add-on and the planner in either order is fine.

## 0.1.1

- Update add-on repository URL to the new capitalized path (`Nayatrei/GenesisPlanner-HA-Addon`). Existing installations keep working — this release just aligns metadata with the canonical repo.
- Housekeeping: tightened docs and README references.

## 0.1.0

- Initial release. Pair your Home Assistant with GenesisPlanner over a Firestore-backed mailbox — no Nabu Casa, domain, or port forwarding required.
