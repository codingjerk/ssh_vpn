#!/bin/ash
set -eu

/sync-users.sh

exec /usr/sbin/sshd -eD
