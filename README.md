# homelab

Infrastructure as code for the homelab.

## Development environment

Development runs in a consistent local Dev Container built from a pinned
Microsoft base image. OpenTofu and uv are downloaded from upstream releases
and verified with SHA-256 checksums. Python and Ansible dependencies are
managed by uv. Podman and the Dev Containers extension remain host-managed
dependencies.

VS Code extensions are pinned in `.devcontainer/devcontainer.json`. Updates are
reviewed and applied deliberately.

Requirements:

- An x86_64 (`amd64`) Linux host
- Podman
- Visual Studio Code
- Dev Containers extension
- VS Code configured with `dev.containers.dockerPath` set to `/usr/bin/podman`

Open this repository in Visual Studio Code and run **Dev Containers: Rebuild
and Reopen in Container**. Container creation runs `uv sync --locked` before
the editor attaches.

Verify the environment from the container terminal:

```shell
bash .devcontainer/scripts/verify-toolchain.sh
```
