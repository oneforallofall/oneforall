
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



Xray_XTLS_Http_func() {

mkdir -p /etc/xrayXtlsHttp/

read -p "port  default:80: " Port
    if   [[ -z "$Port" ]]; then
            Port=80

    fi

read -p "uuid 默认随机 " UUID_input
     if   [[ -z "$UUID_input" ]]; then
            uuid="$(cat '/proc/sys/kernel/random/uuid')"
	else
	    uuid=$UUID_input
      fi


while true
        do
            read -p " 请输入cer path：" cer_path
            if [ ! -f "${cer_path}" ]; then
                echoColor red " certificate path wrong，请重新输入！"
				echoColor green "请输入证书cert文件路径:"
            else
                break
            fi
        done

while true
        do
            read -p " 请输入key path：" key_path
            if [ !  -f "${key_path}" ]; then
                echoColor red " key path wrong，请重新输入！"
				echoColor green "请输入证书key文件路径:"
            else
                break
            fi
        done





cat <<EOF > /etc/xrayXtlsHttp/config.json
{
  "inbounds": [{
    "port": $Port,
    "listen": "0.0.0.0",
    "protocol": "vless",
    "settings": {
      "decryption": "none",
    
      "clients": [
        {
          "id": "$UUID",
          "level": 1,
          "alterId": 0
        }
      ],

      "disableInsecureEncryption": false
    },
    "streamSettings": {
        "network": "tcp",
        "tcpSettings": {"header": { "type": "http",
                                   "request": {
                                        "version": "1.1",
                                        "method": "GET",
                                        "path": ["/"],
                                        "headers": {
                                          "Host": ["www.baidu.com", "www.bing.com"],
                                          "User-Agent": [
                                            "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36",
                                            "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_2 like Mac OS X) AppleWebKit/601.1 (KHTML, like Gecko) CriOS/53.0.2785.109 Mobile/14A456 Safari/601.1.46"
                                          ],
                                          "Accept-Encoding": ["gzip, deflate"],
                                          "Connection": ["keep-alive"],
                                          "Pragma": "no-cache"
                                        }
                                      }
                                  }

                       },
        "security": "xtls",
        "xtlsSettings": {
                    "alpn": [
                        "http/1.1",
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile":"$cer_path", 
                            "keyFile": "$key_path",
                            "ocspStapling": 3600   }
                    ],
                    "minVersion": "1.2" 
                        }
       
        
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  },{
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }]
}
EOF

}



function DownloadxrayXtlsHttpCore(){
	version=`wget -qO- -t1 -T2 --no-check-certificate "https://api.github.com/repos/XTLS/xray-core/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`
	wget -qO- -t1 -T2 --no-check-certificate "https://api.github.com/repos/XTLS/xray-core/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'
	echo -e "The Latest xray version:"`echoColor red "${version}"`"\nDownload..."
    get_arch=`arch`

#https://github.com/XTLS/xray-core/releases/download/v1.6.1/xray-linux-64.zip

temp_f=$(mktemp)
temp_d=$(mktemp -d)


    if [ $get_arch = "x86_64" ];then
        wget -q -O $temp_f  --no-check-certificate https://github.com/XTLS/xray-core/releases/download/${version}/xray-linux-64.zip
        unzip $temp_f -d $temp_d/
        mv -fv $temp_d/xray /usr/bin/xrayXtlsHttp
        mv -fv $temp_d/* /usr/bin/

         
    elif [ $get_arch = "aarch64" ];then
        wget -q -O $temp_f  --no-check-certificate https://github.com/XTLS/xray-core/releases/download/${version}/xray-linux-64.zip
        unzip $temp_f -d $temp_d/
        mv -fv $temp_d/xray /usr/bin/xrayXtlsHttp
        mv -fv $temp_d/* /usr/bin/
   
    else
        echoColor yellowBlack "Error[OS Message]:${get_arch}\nPlease open a issue to https://github.com/XTLS/xray-core/releases/"
        exit
    fi
	if [ -f "/usr/bin/xrayXtlsHttp" ]; then
		chmod 755 /usr/bin/xrayXtlsHttp
		echoColor purple "\nDownload completed."
	else
		echoColor red "Network Error: Can't connect to Github!"
	fi


	cat <<EOF > /etc/systemd/system/xrayXtlsHttp.service
[Unit]
Description=xray Service
Documentation=https://github.com/XTLS/xray-core/
After=network.target nss-lookup.target

[Service]
User=root
#User=nobody
#CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/xrayXtlsHttp -c /etc/xrayXtlsHttp/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
EOF



}



start(){
netstat  -lptnu  |grep xrayXtlsHttp

           echo "/etc/xrayXtlsHttp/config.json" 
           cat "/etc/xrayXtlsHttp/config.json" 
    systemctl daemon-reload
    systemctl enable xrayXtlsHttp
    systemctl start  xrayXtlsHttp
            systemctl restart xrayXtlsHttp
            systemctl status xrayXtlsHttp

}

echo -e "  ${GREEN}1.${PLAIN} 安装 ${BLUE}xrayXtlsHttp${PLAIN}"
echo -e "  ${GREEN}2.${PLAIN} 查看 ${BLUE}config${PLAIN}"
echo -e "  ${GREEN}3.${PLAIN} restart ${BLUE}config${PLAIN}"
echo -e "  ${GREEN}00.${PLAIN} ${BLUE}exit${PLAIN}"


read -p " 选择：" answer
    case $answer in
        1)
            Xray_XTLS_Http_func
            DownloadxrayXtlsHttpCore
            start
netstat -ltnp |grep  xrayXtlsHttp
            ;;
        2)
           echo "/etc/xrayXtlsHttp/config.json" 
           cat "/etc/xrayXtlsHttp/config.json" 
netstat -ltnp  |grep  xrayXtlsHttp
           systemctl status xrayXtlsHttp
            ;;
	3)
netstat -ltnp |grep  xrayXtlsHttp
systemctl restart xrayXtlsHttp
systemctl status xrayXtlsHttp
;;

        00)
       exit
            ;;

esac
