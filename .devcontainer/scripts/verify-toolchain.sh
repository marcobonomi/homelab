#!/usr/bin/env bash
set -euo pipefail

tofu version
uv --version
python3.13 --version
uv run --locked ansible --version
uv run --locked ansible-lint --version
uv run --locked yamllint --version
