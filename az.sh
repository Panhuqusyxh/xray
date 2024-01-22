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

# Sau khi đã thực hiện các lệnh trước, bạn có thể tiếp tục với lệnh cloudflare-ddns --configure
cloudflare-ddns --configure
