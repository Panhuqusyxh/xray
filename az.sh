#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi

# Nếu bạn đang ở root, thì mới thực hiện các lệnh sau
git clone https://github.com/LINKIWI/cloudflare-ddns-client.git && cd cloudflare-ddns-client
sudo apt update -y
sudo apt install -y python-is-python3
sudo apt-get install -y python3-pip
sudo make install

# Thực hiện lệnh cloudflare-ddns --configure và tự động trả lời "K" (API Key) cho câu hỏi
# Sau đó tự động nhập địa chỉ email và API Key khi được yêu cầu
# Cuối cùng, tự động nhập tên miền "svn.dualeovpn.net" khi được yêu cầu
expect -c "
   spawn cloudflare-ddns --configure
   expect \"Choose [T]oken or [K]ey:\"
   send \"K\r\"
   expect \"Enter the email address associated with your CloudFlare account.\"
   send \"dcmnmmmchkh@gmail.com\r\"
   expect \"Enter the API key associated with your CloudFlare account.\"
   send \"3b411374ee6b120fbfc87be4b80e930922034\r\"
   expect \"Comma-delimited domains:\"
   send \"svn.dualeovpn.net\r\"
   interact
"
