export DEBCONF_NONINTERACTIVE_SEEN=true 
export DEBIAN_FRONTEND=noninteractive
apt update
apt install -y nano curl tzdata
