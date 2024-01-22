#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi

# Xóa thư mục cloudflare-ddns-client nếu nó tồn tại
rm -rf /root/cloudflare-ddns-client

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

# Tự động cấu hình cloudflare-ddns-client bằng expect
expect -c "
set timeout -1

spawn cloudflare-ddns --configure

expect {
    \"Quit and cancel at any time with Ctrl-C\" {
        expect \"Change API token/key (y/n):\"
        send -- \"y\r\"
    }
    \"Change API token/key (y/n):\" {
        send -- \"y\r\"
    }
}

expect \"Choose [T]oken or [K]ey:\"
send -- \"k\r\"

expect \"Email:\"
send -- \"dcmnmmmchkh@gmail.com\r\"

expect \"CloudFlare API key:\"
send -- \"3b411374ee6b120fbfc87be4b80e930922034\r\"

expect \"Comma-delimited domains:\"
send -- \"svn.dualeovpn.net\r\"

expect eof
"

# Thực hiện cập nhật DDNS ngay lập tức
cloudflare-ddns --update-now
