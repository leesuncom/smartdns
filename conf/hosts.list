#!/bin/sh
sed -i '/# GitHub520 Host Start/,/# Github520 Host End/d' /etc/hosts
curl https://raw.hellogithub.com/hosts >> /etc/hosts
/etc/init.d/dnsmasq restart
/etc/init.d/AdGuardHome restart
/etc/init.d/mosdns restart
/etc/init.d/smartdns restart
