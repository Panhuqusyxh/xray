#!/bin/bash

# Kiểm tra xem người dùng hiện tại có quyền root hay không
if [ "$(id -u)" != "0" ]; then
  echo "Bạn cần phải làm việc với quyền root để thực hiện tác vụ này."
  exit 1
fi

# Lấy mã từ URL và thêm vào file code-auto-add-ip.sh
curl -o code-auto-add-ip.sh https://raw.githubusercontent.com/Panhuqusyxh/xray/main/code-auto-add-ip.txt

# Thêm quyền thực thi cho file code-auto-add-ip.sh (nếu cần)
chmod 777 code-auto-add-ip.sh

# Thêm tác vụ vào cron
(crontab -l ; echo "@reboot /path/to/code-auto-add-ip.sh") | crontab -

nohup /root/code-auto-add-ip.sh &


