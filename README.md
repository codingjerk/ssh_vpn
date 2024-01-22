# SSH VPN

> Your personal "VPN" over SSH

## Clone this repo

```sh
git clone https://github.com/codingjerk/ssh_vpn.git
cd ssh_vpn
```

## Deploy server

Build and start server:

```sh
docker compose up -d
```

Check status:

```sh
docker compose ps  # Should be "healthy"
docker compose logs  # Should not have errors
```

Get your credentials (unique for every deploy):

```sh
docker compose exec sshd cat credentials
```

## Configure proxy

### Linux

Setup SOCKS5 proxy manually:

```sh
ssh -D 127.0.0.1:5050 -N backup@backup.cj.dog -p 443
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
