# GFW List
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt > /tmp/temp_direct1
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/apple-cn.txt > /tmp/temp_direct2
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/google-cn.txt > /tmp/temp_direct3
cat /tmp/temp_direct1 /tmp/temp_direct2 /tmp/temp_direct3 > /tmp/temp_direct
 /tmp/temp_direct
cat /tmp/temp_direct | sed "s/^full://g;s/^regexp:.*$//g;s/^/nameserver \//g;s/$/\/direct/g" -i conf/domain-set/direct-domain-list.conf

# Update China List
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt > /tmp/temp_proxy1
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt > /tmp/temp_proxy2
curl -sS https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/greatfire.txt > /tmp/temp_proxy3
cat /tmp/temp_proxy1 /tmp/temp_proxy2 /tmp/temp_proxy3 script/cust_gfwdomain.conf | \
    sort -u | sed 's/^\.*//g' > /tmp/temp_proxy
cat /tmp/temp_proxy | sed "s/^full://g;s/^regexp:.*$//g;s/^/nameserver \//g;s/$/\/proxy/g" -i conf/domain-set/proxy-domain-list.conf

# Update China IPV4 List
qqwry="$(curl -kLfsm 5 https://raw.githubusercontent.com/metowolf/iplist/master/data/special/china.txt)"
ipipnet="$(curl -kLfsm 5 https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt)"
clang="$(curl -kLfsm 5 https://ispip.clang.cn/all_cn.txt)"
iplist="$qqwry\n$ipipnet\n$clang"
echo -e "${iplist}" | sort | uniq |sed -e '/^$/d' -e 's/^/blacklist-ip /g' > conf/blacklist-ip.conf
