#!/usr/bin/env bash
set -euo pipefail

readonly version="${1:?uv version is required}"
readonly expected_sha256="${2:?uv SHA-256 is required}"

temp_dir="$(mktemp --directory)"
readonly temp_dir
trap 'rm --recursive --force "${temp_dir}"' EXIT

readonly archive="${temp_dir}/uv.tar.gz"
readonly extracted_dir="${temp_dir}/uv-x86_64-unknown-linux-gnu"
curl --fail --location --proto '=https' --retry 3 --show-error --silent \
    "https://github.com/astral-sh/uv/releases/download/${version}/uv-x86_64-unknown-linux-gnu.tar.gz" \
    --output "${archive}"
printf '%s  %s\n' "${expected_sha256}" "${archive}" \
    | sha256sum --check --strict

tar --extract --gzip --file "${archive}" --directory "${temp_dir}"
install --mode 0755 \
    "${extracted_dir}/uv" \
    "${extracted_dir}/uvx" \
    /usr/local/bin/
