#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_ROOT="${REPO_ROOT}/skills"
TARGET_ROOT="${HOME}/.agents/skills"

if [[ ! -d "${SOURCE_ROOT}" ]]; then
  echo "Error: skills directory not found at ${SOURCE_ROOT}" >&2
  exit 1
fi

if [[ ! -d "${TARGET_ROOT}" ]]; then
  echo "Nothing to do: ${TARGET_ROOT} does not exist"
  exit 0
fi

resolve_path() {
  python3 - "$1" <<'PY'
import os
import sys
print(os.path.realpath(sys.argv[1]))
PY
}

removed=0
for skill_dir in "${SOURCE_ROOT}"/*; do
  if [[ -d "${skill_dir}" && -f "${skill_dir}/SKILL.md" ]]; then
    skill_name="$(basename "${skill_dir}")"
    target_link="${TARGET_ROOT}/${skill_name}"

    if [[ -L "${target_link}" ]]; then
      current_dest="$(resolve_path "${target_link}")"
      expected_dest="$(resolve_path "${skill_dir}")"

      if [[ "${current_dest}" == "${expected_dest}" ]]; then
        rm "${target_link}"
        removed=$((removed + 1))
        echo "Removed ${target_link}"
      else
        echo "Skipped ${target_link} (points elsewhere)"
      fi
    elif [[ -e "${target_link}" ]]; then
      echo "Skipped ${target_link} (not a symlink)"
    fi
  fi
done

echo "Removed ${removed} skill link(s) from ${TARGET_ROOT}"
