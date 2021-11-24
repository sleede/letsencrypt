#!/bin/bash

# Make sure only root can run our script
if [[ "$(id -u)" -ne 0 ]]
 then
   echo "This script must be run as root" 1>&2
   exit 1
fi

copy_files()
{
  LETSENCRYPT_PATH=${1:-/apps/letsencrypt}
  \curl -sSL https://raw.githubusercontent.com/sleede/letsencrypt/master/etc/systemd/system/letsencrypt_renew.service > "/etc/systemd/system/letsencrypt_renew.service"
  \curl -sSL https://raw.githubusercontent.com/sleede/letsencrypt/master/etc/systemd/system/letsencrypt.timer > "/etc/systemd/system/letsencrypt.timer"
  \curl -sSL https://raw.githubusercontent.com/sleede/letsencrypt/master/etc/systemd/system/letsencrypt@.service > "/etc/systemd/system/letsencrypt@.service"

  mkdir -p "$LETSENCRYPT_PATH/etc/config/"
  mkdir -p "$LETSENCRYPT_PATH/etc/webrootauth/"
  \curl -sSL https://raw.githubusercontent.com/sleede/letsencrypt/master/apps/letsencrypt/etc/config/webroot.ini > "$LETSENCRYPT_PATH/etc/config/webroot.ini"
  
  \curl -sSL https://raw.githubusercontent.com/sleede/letsencrypt/master/apps/letsencrypt/commands.sh > "$LETSENCRYPT_PATH/commands.sh"
}

install_commands()
{
  systemctl daemon-reload
  echo "[[ -s \"$LETSENCRYPT_PATH/commands.sh\" ]] && source \"$LETSENCRYPT_PATH/commands.sh\"" | tee -a "$HOME/.bashrc"
}

setup()
{
  copy_files
  install_commands
}

setup "$@"

