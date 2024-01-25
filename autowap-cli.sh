#!/bin/bash

# Kiểm tra xem người dùng hiện tại có quyền root hay không
if [ "$(id -u)" -ne 0 ]; then
  echo "Bạn cần phải là root để chạy lệnh này."
  exit 1
fi

# Dưới đây là các lệnh bạn muốn thực thi nếu người dùng là root
echo "Bạn đang chạy với quyền root."
# Thêm các lệnh của bạn ở đây


# Nội dung của tệp openipwarp.sh
cat > openipwarp.sh <<EOL
#!/bin/bash

# Danh sách các tên miền cần kiểm tra
domain_names=("svn.dualeovpn.net" "aws1.dualeovpn.net" "aws2.dualeovpn.net" "aws3.dualeovpn.net" "aws4.dualeovpn.net" "aws5.dualeovpn.net" "aws6.dualeovpn.net" "aws.dualeovpn.net")

# Tạo một mảng để lưu trữ các địa chỉ IP
ip_addresses=()

# Lặp qua danh sách các tên miền và kiểm tra địa chỉ IP của từng tên miền
for domain in "\${domain_names[@]}"; do
    ip=\$(nslookup "\$domain" | awk -F': ' '/^Address: / { print \$2 }')
    # Kiểm tra xem IP đã tồn tại trong mảng hay chưa
    if [[ ! " \${ip_addresses[@]} " =~ " \${ip} " ]]; then
        ip_addresses+=("\$ip")
    fi
done

# Ghi các địa chỉ IP vào tập tin ipopenwarp.txt, mỗi dòng một địa chỉ IP
for ip in "\${ip_addresses[@]}"; do
    echo "\$ip" >> ipopenwarp.txt
done

# Kiểm tra xem tệp ipopenwarp.txt có tồn tại không
if [ ! -e /root/ipopenwarp.txt ]; then
  echo "Tệp ipopenwarp.txt không tồn tại trong thư mục /root."
  exit 1
fi

# Lặp qua từng địa chỉ IP trong tệp và thêm chúng vào tuyến đường bị loại trừ
while read -r ip; do
  # Kiểm tra xem địa chỉ IP có hợp lệ không (IPv4 hoặc IPv6)
  if [[ \$ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ || \$ip =~ ^[0-9a-fA-F:]+$ ]]; then
    # Thêm địa chỉ IP vào tuyến đường bị loại trừ bằng lệnh warp-cli
    warp-cli add-excluded-route "\$ip"
    echo "Đã thêm \$ip vào tuyến đường bị loại trừ."
  else
    echo "Địa chỉ IP không hợp lệ: \$ip"
  fi
done < /root/ipopenwarp.txt

echo "Các tuyến đường bị loại trừ đã được cập nhật."
EOL

echo "Tệp openipwarp.sh đã được tạo."

#!/bin/bash
chmod 777 /root/openipwarp.sh
# Đường dẫn đến tệp openipwarp.sh
OPENIPWARP_SCRIPT="/root/openipwarp.sh"

# Kiểm tra xem tệp openipwarp.sh đã tồn tại hay chưa
if [ ! -e "$OPENIPWARP_SCRIPT" ]; then
  echo "Tệp openipwarp.sh không tồn tại trong thư mục /root."
  exit 1
fi

# Thêm công việc cron để chạy mỗi phút
(crontab -l ; echo "*/1 * * * * $OPENIPWARP_SCRIPT") | crontab -

echo "Đã tạo công việc cron để chạy $OPENIPWARP_SCRIPT mỗi phút."



#!/bin/bash

# Đường dẫn đến tệp openipwarp.sh
OPENIPWARP_SCRIPT="/root/openipwarp.sh"

# Kiểm tra xem tệp openipwarp.sh đã tồn tại hay chưa
if [ ! -e "$OPENIPWARP_SCRIPT" ]; then
  echo "Tệp openipwarp.sh không tồn tại trong thư mục /root."
  exit 1
fi

# Đường dẫn đến tệp ipopenwarp.txt
IP_OPENWARP_FILE="/root/ipopenwarp.txt"

# Kiểm tra xem tệp ipopenwarp.txt có tồn tại hay không
if [ ! -e "$IP_OPENWARP_FILE" ]; then
  touch "$IP_OPENWARP_FILE"
fi

# Đảm bảo rằng tệp ipopenwarp.txt không chứa các IP trùng lặp
sort -u -o "$IP_OPENWARP_FILE" "$IP_OPENWARP_FILE"

# Thêm công việc cron để chạy mỗi phút
(crontab -l ; echo "*/1 * * * * $OPENIPWARP_SCRIPT") | crontab -

echo "Đã tạo công việc cron để chạy $OPENIPWARP_SCRIPT mỗi phút."

