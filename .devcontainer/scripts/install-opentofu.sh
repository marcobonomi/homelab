#!/usr/bin/env bash
set -euo pipefail

readonly version="${1:?OpenTofu version is required}"
readonly expected_sha256="${2:?OpenTofu SHA-256 is required}"

temp_dir="$(mktemp --directory)"
readonly temp_dir
trap 'rm --recursive --force "${temp_dir}"' EXIT

readonly archive="${temp_dir}/tofu.tar.gz"
curl --fail --location --proto '=https' --retry 3 --show-error --silent \
    "https://github.com/opentofu/opentofu/releases/download/v${version}/tofu_${version}_linux_amd64.tar.gz" \
    --output "${archive}"
printf '%s  %s\n' "${expected_sha256}" "${archive}" \
    | sha256sum --check --strict

tar --extract --gzip --file "${archive}" --directory "${temp_dir}" tofu
install --mode 0755 "${temp_dir}/tofu" /usr/local/bin/tofu
