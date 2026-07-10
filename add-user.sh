#!/bin/sh
set -eu

user=${1:?usage: ./add-user.sh <username>}
credentials=$(dirname "$0")/credentials

if grep -q "^${user}:" "${credentials}" 2>/dev/null; then
    echo "error: user '${user}' already exists in ${credentials}" >&2
    exit 1
fi

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
echo "${user}:${password}" >> "${credentials}"
chmod 600 "${credentials}"

echo "Added '${user}' with password: ${password}"
echo "Apply with: docker compose restart"
