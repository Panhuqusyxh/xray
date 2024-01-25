#!/bin/bash

# Kiểm tra xem người dùng hiện tại có quyền root hay không
if [ "$(id -u)" != "0" ]; then
  echo "Bạn cần phải làm việc với quyền root để thực hiện tác vụ này."
  exit 1
fi

# Tải nội dung từ URL và ghi vào tệp /root/openipwarp.sh
curl -o /root/openipwarp.sh https://raw.githubusercontent.com/Panhuqusyxh/xray/main/code-opwarp.txt

# Cấp quyền truy cập cho tệp /root/openipwarp.sh
chmod 777 /root/openipwarp.sh

# Tạo cron job chạy tệp /root/openipwarp.sh mỗi phút
(crontab -l ; echo "* * * * * /root/openipwarp.sh") | crontab -

echo "Đã cấu hình thành công cron job để chạy /root/openipwarp.sh mỗi phút."
