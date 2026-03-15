#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_ROOT="${REPO_ROOT}/skills"
TARGET_ROOT="${HOME}/.agents/skills"

if [[ ! -d "${SOURCE_ROOT}" ]]; then
  echo "Error: skills directory not found at ${SOURCE_ROOT}" >&2
  exit 1
fi

mkdir -p "${TARGET_ROOT}"

count=0
for skill_dir in "${SOURCE_ROOT}"/*; do
  if [[ -d "${skill_dir}" && -f "${skill_dir}/SKILL.md" ]]; then
    skill_name="$(basename "${skill_dir}")"
    ln -sfn "${skill_dir}" "${TARGET_ROOT}/${skill_name}"
    count=$((count + 1))
    echo "Linked ${skill_name} -> ${skill_dir}"
  fi
done

echo "Installed ${count} skill(s) into ${TARGET_ROOT}"
