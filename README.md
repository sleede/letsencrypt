# letsencrypt
Install Let's encrypt on a server

## Asumption
This script assume you are using [nginx](https://nginx.org/) as a reverse proxy, which is installed in `/apps/nginx/` using [docker compose](https://docs.docker.com/compose/) with a [compose.yaml] file to manage your nginx instance.

## Usage

- create a new certificate

```bash
mkcert example.com www.example.com
```

- delete a certificate

```bash
removecert example.com
```

- list all certificates

```bash
certificates
```

- renew all certificates
This is done automatically on 1st and 15 of each month but you can force renew by running the following:

```bash
systemctl start letsencrypt_renew.service
```
