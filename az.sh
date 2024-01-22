#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi

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
svn.dualeovpn.net
EOF


# Thực hiện cập nhật DDNS ngay lập tức
cloudflare-ddns --update-now

#!/bin/bash

# Thêm tác vụ cron cho cloudflare-ddns
echo "*/1 * * * * /usr/local/bin/cloudflare-ddns --update-now >> /root/ipcf.log 2>&1" > /tmp/cloudflare_cron

# Xóa tác vụ cron cho việc xóa tệp log
crontab -l | grep -v "/root/ipcf.log" | crontab -

# Thêm tác vụ cron cho việc xóa tệp log
echo "0 * * * * rm -f /root/ipcf.log" >> /tmp/cloudflare_cron

# Nhập tất cả tác vụ cron từ tệp tạm thời
crontab /tmp/cloudflare_cron

# Xóa tệp tạm thời
rm /tmp/cloudflare_cron

