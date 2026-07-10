#!/bin/sh
set -eu

user=${1:?usage: ./scripts/add-user.sh <username>}
root=$(dirname "$0")/..
credentials=${root}/credentials

if grep -q "^${user}:" "${credentials}" 2>/dev/null; then
    echo "error: user '${user}' already exists in ${credentials}" >&2
    exit 1
fi

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
echo "${user}:${password}" >> "${credentials}"
chmod 600 "${credentials}"

# Apply immediately if the server is running (credentials file is bind-mounted)
if docker compose -f "${root}/docker-compose.yml" exec sshd /sync-users.sh >/dev/null 2>&1; then
    echo "User '${user}' added and applied to the running server."
else
    echo "User '${user}' added. Server is not running, apply with: docker compose up -d"
fi

# Server address and port for client profiles, overridable via environment
server=${SSH_VPN_SERVER:-$(hostname -f)}
port=${SSH_VPN_PORT:-$(sed -n 's/.*:\([0-9][0-9]*\):22".*/\1/p' "${root}/docker-compose.yml")}
port=${port:-22}

cat <<EOF

== Connection profiles for '${user}' ==

Linux / macOS (SOCKS5 proxy at 127.0.0.1:5050):

    ssh -D 127.0.0.1:5050 -N ${user}@${server} -p ${port}

Android (SSH Custom) / iOS (SSH Tunnel):

    Host:     ${server}
    Port:     ${port}
    User:     ${user}
    Password: ${password}
    Proxy:    SOCKS5 (dynamic forwarding), local port 5050

Import URI (supported by most mobile SSH tunnel apps):

    ssh://${user}:${password}@${server}:${port}
EOF
