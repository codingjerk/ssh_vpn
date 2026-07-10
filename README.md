# SSH VPN

> Your personal "VPN" over SSH

## Clone this repo

```sh
git clone https://github.com/codingjerk/ssh_vpn.git
cd ssh_vpn
```

## Deploy server

Create users (one `username:password` per line in `credentials`):

```sh
cp credentials.example credentials
./scripts/add-user.sh alice  # Generates a password and appends "alice:<password>"
```

Build and start server:

```sh
docker compose up -d
```

Common tasks are also available via [just](https://github.com/casey/just):
`just start`, `just stop`, `just restart`, `just status` and `just add-user alice`.

Check status:

```sh
docker compose ps  # Should be "healthy"
docker compose logs  # Should not have errors
```

## Manage users

Add a user (applied to the running server immediately, no restart needed):

```sh
./scripts/add-user.sh bob
```

The script also prints ready-to-use client profiles (ssh command, Android/iOS
app settings and an import URI). Set `SSH_VPN_SERVER` if the public address
differs from the machine's hostname:

```sh
SSH_VPN_SERVER=backup.cj.dog ./scripts/add-user.sh bob
```

To remove a user, delete their line from `credentials` and recreate the container:

```sh
docker compose up -d --force-recreate
```

## Configure client

### Linux

Setup SOCKS5 proxy manually:

```sh
ssh -D 127.0.0.1:5050 -N alice@backup.cj.dog -p 443
```

Now you can change proxy in your browser to:

- `type: socks5`
- `ip: 127.0.0.1`
- `port: 5050`

It will be better to also forward DNS queries into your tunnel.

Also you can use **sshuttle** ([read docs](https://github.com/sshuttle/sshuttle)),
to setup transparent proxy.

### Windows

TODO: example

### Android

Use [SSH Custom](https://play.google.com/store/apps/details?id=dev.epro.ssc)

### iOS

Use [SSH Tunnel iOS](https://ssh-tunnel-ios.com/)
