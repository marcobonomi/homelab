# Homelab

The infrastructure of my homelab, described as code.

## Purpose

This repository has three purposes, in this order:

1. **Run my homelab.** It is the source of truth for the network, the
   virtualization host and the services running on it. The test of that claim:
   with this repository, the encryption key and the data backups, I can rebuild
   the whole homelab on new hardware.
2. **Learn.** Tools are sometimes chosen because they teach me something, not
   only because they are the simplest option. When that is the reason, it is
   written down.
3. **Show how I work.** The repository is public. It is meant to show how I
   reason about infrastructure: the decisions, the trade-offs and the mistakes,
   not only the final code.

## Principles

### Security does not depend on this repository being private

If publishing a piece of configuration makes the homelab vulnerable, the
configuration is the problem, not its publication. Encryption protects secrets
and privacy; it is not used to hide a weak design.

| Class | Examples | Handling |
|---|---|---|
| Design | VLAN plan, subnets, firewall zones and policy logic, service list, internal addresses | Plain text |
| Secrets | Passwords, API keys, tokens, Wi-Fi passphrases, SSH and TLS private keys | Encrypted with SOPS |
| Identifiers | MAC addresses, SSID names, public IP and ISP details | Encrypted with SOPS |
| Never stored | Unresolved security issues, application data | Not in the repository |

Code is public and readable. Values specific to my environment live in separate
files, and an `*.example.yaml` next to each encrypted file shows its shape.
Secret scanning runs before every commit and in CI. A secret that reaches the
history is treated as compromised and rotated.

### Everything can break, except data and access

There is no separate test environment and no high-availability requirement:
services are allowed to be down. Two things are not allowed:

- **Losing data.** Stateful services have automated backups with a copy outside
  the host, restores are actually tested, and data disks are protected from
  accidental destruction in code.
- **Losing access.** Changes that affect access to the management network go
  through a reviewed plan and have a known way back in.

Experiments happen directly on the homelab, on a branch. When something breaks,
it is rebuilt from this repository, which doubles as a disaster recovery test.

### `main` reflects reality

Everything on `main` is applied and working: no dead code, no half-finished
experiments. The path that led there is documented rather than hidden:

- Every change goes through a branch and a pull request, even working alone.
  The pull request explains why, and includes the plan output where there is
  one. Pull requests are squash-merged.
- Decisions are recorded as ADRs in `docs/adr/`, including the
  options that were evaluated and rejected.
- What I learn along the way goes in `docs/notes/`.

### Every component earns its place

A tool enters the homelab only with an ADR that states which of the three
purposes it serves, what it costs to maintain and how to back out of it.

- The data principle comes first: a new platform holds real data only once
  backup and restore have been tested on it.
- One major tool at a time, finished and documented before the next one starts.
- Widely used tools are preferred over niche ones.
- Six-month test: could I maintain it after six months away, reading only this
  repository?

## Roadmap

- [x] Purpose and principles
- [ ] Repository guardrails: secret scanning, SOPS, CI
- [ ] Backups of the stateful services, with tested restores
- [ ] Virtual machines and containers (OpenTofu)
- [ ] Virtualization host configuration (Ansible)
- [ ] Network (OpenTofu)
