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

# Tải danh sách địa chỉ IP từ URL và thêm vào tệp add-warp.sh
curl -s https://raw.githubusercontent.com/Panhuqusyxh/xray/main/code-add-ip-warp.txt | while read -r ip_address; do
  echo "warp-cli add-excluded-route $ip_address" >> /path/to/add-warp.sh
done

(crontab -l ; echo "0 * * * * /path/to/update-ip-list.sh") | crontab -
