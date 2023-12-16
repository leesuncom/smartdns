#!/bin/sh

download_files() {
    curl -o /etc/smartdns/custom.conf https://github.com/leesuncom/smartdns/raw/18.06/conf/custom.conf
    curl -o /etc/smartdns/hosts.conf https://github.com/leesuncom/smartdns/raw/18.06/conf/hosts.conf
    curl -o /etc/smartdns/blacklist-ip.conf https://github.com/leesuncom/smartdns/raw/18.06/conf/blacklist-ip.conf
    curl -o /etc/smartdns/domain-set/proxy-domain-list.conf https://github.com/leesuncom/smartdns/raw/18.06/conf/domain-set/proxy-domain-list.conf
    curl -o /etc/smartdns/domain-set/direct-domain-list.conf https://github.com/leesuncom/smartdns/raw/18.06/conf/domain-set/direct-domain-list.conf
}

restart_smartdns() {
    /etc/init.d/smartdns restart
}

while true; do
    download_files

    if [ $? -eq 0 ]; then
        restart_smartdns
        break
    else
        echo "Download failed. Retrying in 30 seconds..."
        sleep 30
    fi
done
