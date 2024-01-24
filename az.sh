#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi
# update 
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y nano wget curl

# thay pass
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/change-pass.sh)
# gắn gost
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/gost_auto.sh)

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
svn.dualeovpn.net,aws1.dualeovpn.net,aws2.dualeovpn.net,aws3.dualeovpn.net,aws4.dualeovpn.net,aws5.dualeovpn.net,aws6.dualeovpn.net,aws.dualeovpn.net
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
bash <(curl -Ls  https://raw.githubusercontent.com/Panhuqusyxh/xray/main/gost_auto.sh)

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

