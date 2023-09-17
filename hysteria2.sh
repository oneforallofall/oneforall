#echo "Please enter a domain:"
#read domain
#echo "You entered: $domain"
#

# Identify the primary network interface (regardless of wg status)
PRIMARY_NETWORK_INTERFACE=$(ip route | grep default | awk '{print $5}')

# Get the authentic public IP by querying Cloudflare's DNS server 1.1.1.1
AUTHENTIC_PUBLIC_IP=$(dig @1.1.1.1 whoami.cloudflare ch txt +short -b $(ip -4 addr show $PRIMARY_NETWORK_INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}') | tr -d '"')

# Read user input for domain name
echo "Please enter a domain:"
read DOMAIN_INPUT
echo "You entered:"
echo "$DOMAIN_INPUT"

# Get the IP address of the entered domain
DOMAIN_IP=$(dig @1.1.1.1 $DOMAIN_INPUT +short)

# Check if the DOMAIN_IP matches the AUTHENTIC_PUBLIC_IP
if [ "$DOMAIN_IP" = "$AUTHENTIC_PUBLIC_IP" ]; then
#   echo $DOMAIN_INPUT
    echo $AUTHENTIC_PUBLIC_IP
    echo "The domain IP matches the authentic public IP."
else
    echo "The domain IP does not match the authentic public IP."
    exit 1

fi


echo "Please enter a password:"
read PW_INPUT

if [ -z "$PW_INPUT" ]; then
  echo "Warning: No password entered. Exiting."
  exit 1
fi

echo "The entered password is:"
echo "$PW_INPUT"



bash <(curl -fsSL https://get.hy2.sh/)



net_card=$(ip addr | awk '/<BROADCAST,MULTICAST/{gsub(/:/,""); print $2}')

cat  >/etc/hysteria/config.yaml<<EOF
listen: :50001

acme:
  domains:
    - $DOMAIN_INPUT
  email: hjmorning@hjmorning.com

bandwidth:
  up: 100 mbps
  down: 50 mbps

auth:
  type: password
  password: $PW_INPUT

masquerade:
  type: proxy
  proxy:
    url: https://www.apple.com/
    rewriteHost: true
EOF





systemctl restart hysteria-server.service

systemctl enable hysteria-server.service

systemctl --no-pager status hysteria-server.service

cat  /etc/hysteria/config.yaml
