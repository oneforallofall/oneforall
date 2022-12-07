#!/usr/bin/bash
clear     
echo -e "# ${GREEN}作者${PLAIN}: 网络跳越(hijk)"
echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/hijkclub"

Red_font_prefix="\033[31m"
Font_color_suffix="\033[0m"


apt install -y  aptitude apt-get  jq  dnsutils wget curl sudo >/dev/null 2>&1
aptitude  install  -y  jq  dnsutils wget curl   sudo >/dev/null 2>&1
apt-get  -y install  jq  dnsutils wget curl    sudo  >/dev/null 2>&1

dnf install -y bind-utils  >/dev/null 2>&1
yum install -y bind-utils >/dev/null 2>&1


 

trojan='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/trojan-go.sh)'

v2ray='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/v2ray.sh)'
tuic='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/tuic.sh)'
curl -s --max-time 10 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Foneforallofall%2Fcount&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false" | tail -3 | head -n 1 | awk '{print $5,$7}' >/dev/null 2>&1
xray='bash <(curl -sL https://raw.githubusercontent.com/daveleung/hijkpw-scripts-mod/main/xray_mod1.sh)'
hysteria='bash <(curl -fsSL https://git.io/hysteria.sh)'


while true
do
read  -p "$(echo -e "请选择

${Red_font_prefix}1${Font_color_suffix} trojan-go 建议
${Red_font_prefix}2${Font_color_suffix} v2ray 
${Red_font_prefix}3${Font_color_suffix} xray  （选择多）
${Red_font_prefix}4${Font_color_suffix} hysteria 速度快，建议
${Red_font_prefix}5${Font_color_suffix} tuic 不QoS的网络 上网/刷视频快

\r\n
")" choose
	case $choose in
		1) eval $trojan  ;;
		2) eval $v2ray ;;
		3) eval $xray ;;
		4) eval $hysteria ;;
		5) eval $tuic ;;
	 
		*) echo "wrong input" ;;
	esac

done
exit
