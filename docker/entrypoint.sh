#!/bin/ash
set -eu

getent group tunnel >/dev/null || groupadd -r tunnel

while IFS=: read -r user password; do
    case "${user}" in ""|\#*) continue ;; esac
    id "${user}" >/dev/null 2>&1 || useradd -r -d / -s /sbin/nologin -G tunnel -c "VPN user" "${user}"
    echo "${user}:${password}" | chpasswd
done < /run/secrets/credentials

exec /usr/sbin/sshd -eD
