#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi
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
svn.dualeovpn.net,aws1.dualeovpn.net,aws2.dualeovpn.net,aws3.dualeovpn.net,aws4.dualeovpn.net,aws5.dualeovpn.net,aws6.dualeovpn.net
EOF





# Cài xrayr 
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/xrayr1.sh)

# Đường dẫn tới tệp cấu hình XrayR
config_file="/etc/XrayR/config.yml"

# Xóa nội dung của tệp cấu hình
echo -n "" > "$config_file"

# Lấy nội dung từ URL và thêm vào tệp cấu hình
curl -sSfL "https://raw.githubusercontent.com/Panhuqusyxh/xray/main/code_xrayr_az.txt" >> "$config_file"

# Kết thúc thông báo
echo "Nội dung của $config_file đã được cập nhật từ URL."
xrayr restart
clear
# add vps lên vps.dualeovpn.net

while true; do
    echo "Bạn muốn gắn VPS lên AZ 1 ---> AZ 6, vui lòng chọn số từ 1 đến 6 "
    echo -n "Nhập số: "
    # Đọc lựa chọn từ người dùng
    read choice

    # Kiểm tra lựa chọn và thực hiện hành động tương ứng
    case $choice in
      1)
        curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install_en.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh install_agent vps1.dualeovpn.net 5555 YAu6icQHhwxzh95qYS
        break
        ;;
      2)
        curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install_en.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh install_agent vps1.dualeovpn.net 5555 9vLuEjo9UA3iqtWhS6
        break
        ;;
      3)
        curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install_en.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh install_agent vps1.dualeovpn.net 5555 TtVVb7jKQN7OqebCv6
        break
        ;;
      4)
        curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install_en.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh install_agent vps1.dualeovpn.net 5555 YPBuznRdpkWmXZnCjO
        break
        ;;
      5)
        curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install_en.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh install_agent vps1.dualeovpn.net 5555 RQYJRiQAVWenqr7EgV
        break
        ;;
      6)
        curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install_en.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh install_agent vps1.dualeovpn.net 5555 YTJbls2tx28MspaPuq
        break
        ;;
      *)
        echo "Lựa chọn không hợp lệ. Vui lòng chọn số từ 1 đến 6."
        ;;
    esac
done
# Thực hiện cập nhật DDNS ngay lập tức
cloudflare-ddns --update-now
# gost setup tiktok

# Tải Gost
wget -N --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz

# Giải nén Gost
gzip -d gost-linux-amd64-2.11.5.gz

# Đổi tên tệp thực thi
mv gost-linux-amd64-2.11.5 gost

# Cấp quyền thực thi cho tệp Gost
chmod 777 gost
# Chạy gost
nohup ./gost -L udp://:10066 -L tcp://:10066 -F relay+tls://sv.dualeovpn.net:20066 >> /dev/null 2>&1 &
nohup ./gost -L udp://:10004 -L tcp://:10004 -F relay+tls://sv.dualeovpn.net:20004 >> /dev/null 2>&1 &
# tạo tệp cron
echo '#!/bin/bash' > gost_auto.sh
echo 'nohup ./gost -L udp://:10066 -L tcp://:10066 -F relay+tls://sv.dualeovpn.net:20066 >> /dev/null 2>&1 &' >> gost_auto.sh
echo 'nohup ./gost -L udp://:10004 -L tcp://:10004 -F relay+tls://sv.dualeovpn.net:20004 >> /dev/null 2>&1 &' >> gost_auto.sh
# cấp quyền 
sudo chmod 777 gost_auto.sh





# Ghi tác vụ cron đầu tiên vào tệp /root/cloudflare_cron
echo "*/1 * * * * /usr/local/bin/cloudflare-ddns --update-now >> /root/ipcf.log 2>&1" > /root/cloudflare_cron

# Ghi tác vụ cron thứ hai vào tệp /root/cloudflare_cron (chú ý sử dụng >> để thêm vào, không phải ghi đè)
echo "@reboot /root/gost_auto_start.sh" >> /root/cloudflare_cron

# Ghi tác vụ cron thứ ba vào tệp /root/cloudflare_cron (chú ý sử dụng >> để thêm vào, không phải ghi đè)
echo "0 * * * * rm -f /root/ipcf.log" >> /root/cloudflare_cron

# Nhập tất cả tác vụ cron từ tệp tạm thời
crontab /root/cloudflare_cron

# Xóa tệp tạm thời
rm /root/cloudflare_cron















clear 
echo -e "\e[30;48;5;82mCài xong AZ\e[0m Lên WEB"
#!/bin/bash
# khởi động lại 
echo "Bạn có muốn khởi động lại VPS không? (nhấn Enter để đồng ý, n để hủy)"
read answer

if [ -z "$answer" ] || [ "$answer" == "y" ]; then
    echo "Khởi động lại VPS..."
    sudo reboot
else
    echo "Không khởi động lại VPS."
fi

