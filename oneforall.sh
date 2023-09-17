#!/usr/bin/bash
Red_font_prefix="\033[31m"
Font_color_suffix="\033[0m"

clear     
echo -e "# ${GREEN}作者${PLAIN}: 网络跳越(hijk)"
echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/hijkclub"
#echo -e "by 代码搬运工"


apt install -y  aptitude apt-get  jq  dnsutils wget curl sudo
# >/dev/null 2>&1
aptitude  install  -y  jq  dnsutils wget curl 
apt-get  -y install  jq  dnsutils wget curl    sudo  

dnf install -y bind-utils  >/dev/null 2>&1
yum install -y bind-utils >/dev/null 2>&1


trojan='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/trojan-go.sh)'
xray_grpc='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/xray_grpc.sh)'
v2ray='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/v2ray.sh)'
tuic='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/tuic.sh)'
curl -s --max-time 10 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Foneforallofall%2Fcount&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false" | tail -3 | head -n 1 | awk '{print $5,$7}' >/dev/null 2>&1
xray='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/xray.sh )'
xtls_http='bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/xtls_http.sh ) '
#xray='bash <(curl -sL https://raw.githubusercontent.com/daveleung/hijkpw-scripts-mod/main/xray_mod1.sh)'
hysteria='bash <(curl -fsSL https://git.io/hysteria.sh)'
IO='wget -qO- git.io/superbench.sh | bash'
back_route='curl https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh -sSf | sh'
back_route_de='wget -qO- git.io/besttrace | bash'
media='bash <(curl -L -s check.unlock.media)'
tools_other='wget -O box.sh https://raw.githubusercontent.com/BlueSkyXN/SKY-BOX/main/box.sh && chmod +x box.sh && clear && ./box.sh'

while true
do
read  -p "$(echo -e "请选择

${Red_font_prefix}1${Font_color_suffix} trojan-go 如果容易被封443，建议选择websocket
${Red_font_prefix}2${Font_color_suffix} v2ray 
${Red_font_prefix}3${Font_color_suffix} xray  （选择多）
${Red_font_prefix}4${Font_color_suffix} hysteria 速度快，建议
${Red_font_prefix}5${Font_color_suffix} tuic 没有UDP QoS的网络 上网/刷视频快
${Red_font_prefix}6${Font_color_suffix} IO硬盘和网络速度测试
${Red_font_prefix}7${Font_color_suffix} 回程路由
${Red_font_prefix}8${Font_color_suffix} 回程路由(详细)
${Red_font_prefix}9${Font_color_suffix} 流媒体解锁测试
${Red_font_prefix}10${Font_color_suffix} vless xtls 简单粗暴,下载神器跑满宽带
  (自己找运营商免流网址，填在手机端 ，有可能免流 )
${Red_font_prefix}11${Font_color_suffix} vless Grpc 开网页非常快 
${Red_font_prefix}12${Font_color_suffix} 别人的工具箱，各种功能 自己探索去
${Red_font_prefix}13${Font_color_suffix} 非常快的 hysteria2 

\r\n
")" choose
	case $choose in
		1) eval $trojan  ;;
		2) eval $v2ray ;;
		3) eval $xray ;;
		4) eval $hysteria ;;
		5) eval $tuic ;;
		6) eval $IO ;;
		7) eval $back_route ;;
		8) eval $back_route_de ;;
		9) eval $media ;;
		10) eval $xtls_http;;
		11) eval $xray_grpc;;
		12) eval $tools_other;;
  		13) bash <(curl -fsSL  https://raw.githubusercontent.com/oneforallofall/oneforall/main/hysteria2.sh ) ;;
	 
		*) echo "wrong input" ;;
	esac

done
exit
