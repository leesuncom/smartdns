#!/bin/sh
sed -i '/# GitHub520 Host Start/,/# Github520 Host End/d' /etc/hosts
curl https://raw.hellogithub.com/hosts >> /etc/hosts

rm /tmp/etc/smartdns/cn.conf    /tmp/etc/smartdns/domain-forwarding.list   /tmp/etc/smartdns/domain-block.list

curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt"  >> /tmp/etc/smartdns/cn.conf
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt"    >> /tmp/etc/smartdns/cn.conf
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/google-cn.txt"   >> /tmp/etc/smartdns/cn.conf

rm /etc/smartdns/cn.conf
sed "s/^full://g;s/^regexp:.*$//g;s/^/nameserver \//g;s/$/\/cn/g" -i /tmp/etc/smartdns/cn.conf
cat /tmp/etc/smartdns/cn.conf > /etc/smartdns/cn.conf

curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt"  >> /tmp/etc/smartdns/domain-forwarding.list
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt"        >> /tmp/etc/smartdns/domain-forwarding.list
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/greatfire.txt"  >> /tmp/etc/smartdns/domain-forwarding.list

rm /etc/smartdns/domain-forwarding.list
sed "s/^full://g;s/^regexp:.*$//g;s/^/nameserver \//g;s/$/\/gfwlist/g" -i /tmp/etc/smartdns/domain-forwarding.list
cat /tmp/etc/smartdns/domain-forwarding.list > /etc/smartdns/domain-forwarding.list

curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt"  >> /tmp/etc/smartdns/domain-block.list
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-spy.txt"  >> /tmp/etc/smartdns/domain-block.list
curl  "https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/win-extra.txt"  >> /tmp/etc/smartdns/domain-block.list

rm /etc/smartdns/domain-block.list
sed "s/^full://g;s/^regexp:.*$//g;s/^/address \//g;s/$/\/#/g" -i /tmp/etc/smartdns/domain-block.list
cat /tmp/etc/smartdns/domain-block.list > /etc/smartdns/domain-block.list

/etc/init.d/dnsmasq restart
/etc/init.d/AdGuardHome restart
/etc/init.d/mosdns restart
/etc/init.d/smartdns restart
