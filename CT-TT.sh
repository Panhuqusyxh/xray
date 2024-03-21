#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/change-pass.sh)
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/change-pass.sh)
# update 
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y nano wget curl
# thay pass
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/change-pass.sh)
# add bbr 
wget sh.alhttdw.cn/d11.sh && bash d11.sh

# Xóa thư mục cài đặt
sudo rm -rf /usr/local/bin/cloudflare-ddns

# Xóa thư mục git đã sao chép
rm -rf ~/cloudflare-ddns-client

# Xóa tài khoản cấu hình cloudflare-ddns
rm -rf ~/.cloudflare-ddns

# Xóa tệp cấu hình tùy chọn nếu có
rm -f ~/.cloudflare-ddns-config

# Clone repository và kiểm tra lỗi
git clone https://github.com/LINKIWI/cloudflare-ddns-client.git && cd cloudflare-ddns-client || {
    echo "Lỗi khi clone repository. Kiểm tra kết nối mạng của bạn."
    exit 1
}

# Cập nhật gói và cài đặt phụ thuộc
apt update -y && apt install -y python-is-python3 python3-pip expect || {
    echo "Lỗi cài đặt các gói phụ thuộc. Kiểm tra kết nối mạng và quyền của bạn."
    exit 1
}

# Cài đặt cloudflare-ddns-client
make install || {
    echo "Lỗi trong quá trình cài đặt cloudflare-ddns-client."
    exit 1
}

# Cấu hình thông tin CloudFlare DDNS
cloudflare-ddns --configure << EOF
K
dcmnmmmchkh@gmail.com
3b411374ee6b120fbfc87be4b80e930922034
3.thanhtong.top,aws.dualeovpn.net
EOF


# Tải Gost
wget -N --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz

# Giải nén Gost
gzip -d gost-linux-amd64-2.11.5.gz

# Đổi tên tệp thực thi
mv gost-linux-amd64-2.11.5 gost

# Cấp quyền thực thi cho tệp Gost
chmod 777 gost

# Chạy gost
nohup ./gost -L udp://:10080 -L tcp://:10080 -F relay+tls://sv.dualeovpn.net:20080 >> /dev/null 2>&1 &
nohup ./gost -L udp://:10066 -L tcp://:10066 -F relay+tls://sv.dualeovpn.net:20066 >> /dev/null 2>&1 &
# tạo tệp cron

sudo touch gost_auto.sh
echo '#!/bin/bash' > gost_auto.sh
echo 'nohup ./gost -L udp://:10080 -L tcp://:10080 -F relay+tls://sv.dualeovpn.net:20080 >> /dev/null 2>&1 &' >> gost_auto.sh
echo 'nohup ./gost -L udp://:10066 -L tcp://:10066 -F relay+tls://sv.dualeovpn.net:20066 >> /dev/null 2>&1 &' >> gost_auto.sh

# cấp quyền 

sudo chmod 777 gost_auto.sh


# Ghi tác vụ cron thứ hai vào tệp /root/cloudflare_cron (chú ý sử dụng >> để thêm vào, không phải ghi đè)
echo "@reboot /root/gost_auto.sh" >> /root/cloudflare_cron
echo "*/1 * * * * /root/gost_auto.sh" >> /root/cloudflare_cron

# Ghi tác vụ cron thứ ba vào tệp /root/cloudflare_cron (chú ý sử dụng >> để thêm vào, không phải ghi đè)
echo "0 * * * * rm -f /root/ipcf.log" >> /root/cloudflare_cron

# Nhập tất cả tác vụ cron từ tệp tạm thời
crontab /root/cloudflare_cron

# Xóa tệp tạm thời
rm /root/cloudflare_cron


ps aux | grep gost
