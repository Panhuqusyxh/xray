#!/bin/bash

do_red='\033[0;31m'
do_green='\033[0;32m'
do_yellow='\033[0;33m'
do_plain='\033[0m'

thu_muc_hien_tai=$(pwd)

# Kiểm tra quyền root
[[ $EUID -ne 0 ]] && echo -e "${do_red}Lỗi:${do_plain} Bạn phải chạy script này với quyền root!\n" && exit 1

# Kiểm tra hệ điều hành
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${do_red}Không phát hiện phiên bản hệ điều hành, vui lòng liên hệ tác giả script!${do_plain}\n" && exit 1
fi

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
    arch="64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    arch="arm64-v8a"
elif [[ $arch == "s390x" ]]; then
    arch="s390x"
else
    arch="64"
    echo -e "${do_red}Kiểm tra kiến trúc thất bại, sử dụng kiến trúc mặc định: ${arch}${do_plain}"
fi

echo "Kiến trúc: ${arch}"

if [ "$(getconf WORD_BIT)" != '32' ] && [ "$(getconf LONG_BIT)" != '64' ] ; then
    echo "Phần mềm này không hỗ trợ hệ thống 32 bit (x86), hãy sử dụng hệ thống 64 bit (x86_64). Nếu kiểm tra sai, vui lòng liên hệ tác giả"
    exit 2
fi

os_version=""

# Phiên bản hệ điều hành
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${do_red}Vui lòng sử dụng CentOS 7 hoặc phiên bản cao hơn của hệ điều hành!${do_plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${do_red}Vui lòng sử dụng Ubuntu 16 hoặc phiên bản cao hơn của hệ điều hành!${do_plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${do_red}Vui lòng sử dụng Debian 8 hoặc phiên bản cao hơn của hệ điều hành!${do_plain}\n" && exit 1
    fi
fi

cai_dat_co_so() {
    if [[ x"${release}" == x"centos" ]]; then
        yum install wget curl unzip tar crontabs socat -y
        apt update -y
        apt install wget curl unzip tar cron socat -y
    fi
}

# 0: đang chạy, 1: không chạy, 2: chưa cài đặt
kiem_tra_trang_thai() {
    if [[ ! -f /etc/systemd/system/XrayR.service ]]; then
        return 2
    fi
    temp=$(systemctl status XrayR | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ x"${temp}" == x"running" ]]; then
        return 0
    else
        return 1
    fi
}

cai_dat_acme() {
    curl https://get.acme.sh | sh
}

cai_dat_XrayR() {
    if [[ -e /usr/local/XrayR/ ]]; then
        rm /usr/local/XrayR/ -rf
    fi

    mkdir /usr/local/XrayR/ -p
    cd /usr/local/XrayR/

    last_version="v0.8.8"
    url="https://github.com/XrayR-project/XrayR/releases/download/${last_version}/XrayR-linux-${arch}.zip"
    echo -e "Bắt đầu cài đặt XrayR ${last_version}"
    wget -q -N --no-check-certificate -O /usr/local/XrayR/XrayR-linux.zip ${url}
    if [[ $? -ne 0 ]]; then
        echo -e "${do_red}Tải về XrayR ${last_version} thất bại, hãy đảm bảo rằng phiên bản này tồn tại${do_plain}"
        exit 1
    fi

    unzip XrayR-linux.zip
    rm XrayR-linux.zip -f
    chmod +x XrayR
    mkdir /etc/XrayR/ -p
    rm /etc/systemd/system/XrayR.service -f
    file="https://github.com/XrayR-project/XrayR-release/raw/master/XrayR.service"
    #cp -f XrayR.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl stop XrayR
    systemctl enable XrayR

    echo "------------------------------------------"
}

# cai_dat_acme
cai_dat_XrayR
