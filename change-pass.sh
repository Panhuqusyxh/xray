#!/bin/bash

# Kiểm tra xem script có được thực thi bởi root hay không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn cần chạy script này với quyền root."
    exit 1
fi

# Thay đổi mật khẩu của người dùng root thành "aaa"
echo "root:aaa" | chpasswd

# Cấp quyền SSH cho người dùng root
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Khởi động lại dịch vụ SSH để áp dụng thay đổi
service ssh restart

echo "Đã cấp quyền SSH cho người dùng root và thay đổi mật khẩu thành công."
