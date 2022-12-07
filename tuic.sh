RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'

function echoColor() {
	case $1 in
		# 红色
	"red")
		echo -e "\033[31m${printN}$2 \033[0m"
		;;
		# 天蓝色
	"skyBlue")
		echo -e "\033[1;36m${printN}$2 \033[0m"
		;;
		# 绿色
	"green")
		echo -e "\033[32m${printN}$2 \033[0m"
		;;
		# 白色
	"white")
		echo -e "\033[37m${printN}$2 \033[0m"
		;;
	"magenta")
		echo -e "\033[31m${printN}$2 \033[0m"
		;;
		# 黄色
	"yellow")
		echo -e "\033[33m${printN}$2 \033[0m"
		;;
        # 紫色
    "purple")
        echo -e "\033[1;;35m${printN}$2 \033[0m"
        ;;
        #
    "yellowBlack")
        # 黑底黄字
        echo -e "\033[1;33;40m${printN}$2 \033[0m"
        ;;
	"greenWhite")
		# 绿底白字
		echo -e "\033[42;37m${printN}$2 \033[0m"
		;;
	esac
}

function downloadTuicCore(){
	version=`wget -qO- -t1 -T2 --no-check-certificate "https://api.github.com/repos/EAimTY/tuic/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`
	wget -qO- -t1 -T2 --no-check-certificate "https://api.github.com/repos/EAimTY/tuic/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'
	echo -e "The Latest tuic version:"`echoColor red "${version}"`"\nDownload..."
    get_arch=`arch`
    # https://github.com/EAimTY/tuic/releases/download/0.8.5/tuic-server-0.8.5-x86_64-linux-arm64-musl  
    # https://github.com/EAimTY/tuic/releases/download0.8.5/tuic-server0.8.5-x86_64-linux-musl
    if [ $get_arch = "x86_64" ];then
        wget -q -O /usr/bin/Tuic --no-check-certificate https://github.com/EAimTY/tuic/releases/download/${version}/tuic-server-"${version}"-"${get_arch}"-linux-musl
        
       #  echo "https://github.com/EAimTY/tuic/releases/download/${version}/tuic-server-"${version}"-${get_arch}-linux-musl"
         
    elif [ $get_arch = "aarch64" ];then
        wget -q -O /usr/bin/Tuic --no-check-certificate https://github.com/EAimTY/tuic/releases/download/${version}/tuic-server-"${version}"-"${get_arch}"-linux-musl
   
	elif [ $get_arch = "i386" ];then
        wget -q -O /usr/bin/Tuic --no-check-certificate https://github.com/EAimTY/tuic/releases/download/${version}/tuic-server-"${version}"-"${get_arch}"-macos
    else
        echoColor yellowBlack "Error[OS Message]:${get_arch}\nPlease open a issue to https://github.com/EAimTY/tuic/releases/"
        exit
    fi
	if [ -f "/usr/bin/Tuic" ]; then
		chmod 755 /usr/bin/Tuic
		echoColor purple "\nDownload completed."
	else
		echoColor red "Network Error: Can't connect to Github!"
	fi
}

config()
{

read -p "监听端口,默认12345:" ListenPort6
    if   [[ -z "$ListenPort6" ]]; then
            ListenPort6="12345"

    fi



read -p "拥塞控制加速bbr/bbr2（默认bbr）:" bbrbbr2
    if   [[ -z "$bbrbbr2" ]]; then
            bbrbbr2="bbr"

    fi


#
#read -p "监听v4端口默认55554:" ListenPort4
#    if   [[ -z "$ListenPort4" ]]; then
#            ListenPort4="55554"
#
#    fi

read -p "Token默认t.me/hijkclub:" TokenPassword
    if   [[ -z "$TokenPassword" ]]; then
            TokenPassword="t.me/hijkclub"

    fi

while true
        do
            read -p " 请输入cer path：" cert_path
            if [[ -z "${cert_path}" ]]; then
                echoColor red " certificate path wrong，请重新输入！"
            else
                break
            fi
        done

while true
        do
            read -p " 请输入key path：" key_path
            if [[ -z "${key_path}" ]]; then
                echoColor red " key path wrong，请重新输入！"
            else
                break
            fi
        done


mkdir -p /etc/tuic/

#
#		cat <<EOF > /etc/tuic/config4.json
#{
#    "port": ${ListenPort4},
#    "token": ["1"],
#    "certificate": "${cert_path}",
#    "private_key": "${key_path}",
#
#    "ip": "0.0.0.0",
#    "congestion_controller": "bbr",
#    "max_idle_time": 15000,
#    "authentication_timeout": 1000,
#    "alpn": ["h3"],
#    "max_udp_relay_packet_size": 1500,
#    "log_level": "info"
#}
#EOF
#



		cat <<EOF > /etc/tuic/config.json
{
    "port":${ListenPort6},
    "token": ["1"],
    "certificate": "${cert_path}",
    "private_key": "${key_path}",

    "ip": "::",
    "congestion_controller": "${bbrbbr2}",
    "max_idle_time": 15000,
    "authentication_timeout": 1000,
    "alpn": ["h3"],
    "max_udp_relay_packet_size": 1500,
    "log_level": "info"
}
EOF



#
#	cat <<EOF > /etc/systemd/system/tuic4.service
#[Unit]
#Description=Tuic Service
#Documentation=https://github.com/EAimTY/tuic/
#After=network.target nss-lookup.target
#
#[Service]
#User=root
##User=nobody
##CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
##AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#NoNewPrivileges=true
#ExecStart=/usr/bin/Tuic -c /etc/tuic/config4.json
#Restart=on-failure
#RestartPreventExitStatus=23
#
#[Install]
#WantedBy=multi-user.target
#EOF
#


	cat <<EOF > /etc/systemd/system/tuic.service
[Unit]
Description=Tuic Service
Documentation=https://github.com/EAimTY/tuic/
After=network.target nss-lookup.target

[Service]
User=root
#User=nobody
#CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/Tuic -c /etc/tuic/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
EOF



}



start(){


            systemctl restart tuic
            systemctl status tuic

           echo "/etc/tuic/config.json" 
           cat "/etc/tuic/config.json" 

           # systemctl restart tuic4
           # systemctl status tuic4
           # systemctl restart tuic6
           # systemctl status tuic6
}

echo -e "  ${GREEN}1.${PLAIN} 安装 ${BLUE}tuic${PLAIN}"
echo -e "  ${GREEN}2.${PLAIN} 查看 ${BLUE}config${PLAIN}"
echo -e "  ${GREEN}3.${PLAIN} restart ${BLUE}config${PLAIN}"
echo -e "  ${GREEN}00.${PLAIN} ${BLUE}exit${PLAIN}"


read -p " 选择：" answer
    case $answer in
        1)
            downloadTuicCore
            config
           start
            ;;
        2)
           echo "/etc/tuic/config.json" 
           cat "/etc/tuic/config.json" 
           systemctl status tuic
          # systemctl status tuic4
          # systemctl status tuic6
          # echo "/etc/tuic/config4.json" 
          # echo "/etc/tuic/config6.json" 
          # cat "/etc/tuic/config4.json" 
          # cat "/etc/tuic/config6.json" 
            ;;
	3)
systemctl restart tuic
systemctl status tuic
#systemctl restart tuic6
#systemctl status tuic6
;;

        00)
       exit
            ;;

esac
