#!/bin/sh
sed -i '/# GitHub520 Host Start/,/# Github520 Host End/d' /etc/hosts
curl https://raw.hellogithub.com/hosts >> /etc/hosts
/etc/init.d/dnsmasq restart
/etc/init.d/AdGuardHome restart
/etc/init.d/mosdns restart

rm /tmp/etc/smartdns/cn.txt   /tmp/etc/smartdns/gfwlist.txt   /tmp/etc/smartdns/ipv4list.txt

curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt"  >> /tmp/etc/smartdns/cn.txt
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt"    >> /tmp/etc/smartdns/cn.txt
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/google-cn.txt"   >> /tmp/etc/smartdns/cn.txt

rm /etc/smartdns/cn.txt
sed "s/^full://g;s/^regexp:.*$//g;s/^/nameserver \//g;s/$/\/cn/g" -i /tmp/etc/smartdns/cn.conf
cat /tmp/etc/smartdns/cn.conf > /etc/smartdns/cn.txt

curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt"  >> /tmp/etc/smartdns/gfwlist.txt
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt"        >> /tmp/etc/smartdns/gfwlist.txt
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/greatfire.txt"  >> /tmp/etc/smartdns/gfwlist.txt

rm /etc/smartdns/gfwlist.txt
sed "s/^full://g;s/^regexp:.*$//g;s/^/nameserver \//g;s/$/\/gfwlist/g" -i /tmp/etc/smartdns/gfwlist.txt
cat /tmp/etc/smartdns/gfwlist.txt > /etc/smartdns/gfwlist.txt

curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt"  >> /tmp/etc/smartdns/ipv4list.txt
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-spy.txt"  >> /tmp/etc/smartdns/ipv4list.txt
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-extra.txt"  >> /tmp/etc/smartdns/ipv4list.txt

rm /etc/smartdns/ipv4list.txt
sed "s/^full://g;s/^regexp:.*$//g;s/^/address \//g;s/$/\/#/g" -i /tmp/etc/smartdns/ipv4list.txt
cat /tmp/etc/smartdns/ipv4list.txt > /etc/smartdns/ipv4list.txt

/etc/init.d/smartdns restart
