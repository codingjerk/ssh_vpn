# TODO

## `add-user.sh` improvements (next stage)

1. **Apply new users to the running container without a restart** — after appending
   to `credentials`, run the user-creation logic in-place via
   `docker compose exec sshd ...` (create user, add to `tunnel` group, `chpasswd`),
   so new users can connect immediately.

2. **Generate client profiles for the new user** — after adding a user, print
   ready-to-use connection profiles for SSH tunneling apps:
   - plain `ssh -D ...` command (Linux/macOS)
   - SSH Custom (Android)
   - SSH Tunnel (iOS)
