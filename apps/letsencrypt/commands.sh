alias certificates='/usr/bin/docker run --rm --name certbot -v "/apps/letsencrypt/etc:/etc/letsencrypt" certbot/certbot:latest certificates'

removecert() {
  /usr/bin/docker run --rm --name certbot -v "/apps/letsencrypt/etc:/etc/letsencrypt" certbot/certbot:latest delete --cert-name "$1"
}

mkcert() {
  local name=$(echo "$1" | sed 's/\.[^.]*$//' | sed 's/\./-/g')
  cp /apps/letsencrypt/etc/config/webroot.ini "/apps/letsencrypt/etc/config/$name.ini"
  sed -i.bak "s/DOMAINS_REPLACE/$(IFS=, ; echo "$*")/g" "/apps/letsencrypt/etc/config/$name.ini"
  rm "/apps/letsencrypt/etc/config/$name.ini.bak"
  systemctl start "letsencrypt@$name.service"
}
