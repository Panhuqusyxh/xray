#!/bin/bash

# Tìm và xóa file 1.sh, a.sh, b.sh nếu tồn tại
files_to_delete=("1.sh" "a.sh" "b.sh")

for file in "${files_to_delete[@]}"; do
    if [ -e "$file" ]; then
        rm "$file"
        echo "Đã xóa file $file."
    else
        echo "File $file không tồn tại."
    fi
done


read -p "Chọn tên người dùng (
1: dualeo Enter để sử dụng mặc định dualeo
2: thanh ): " choice

case $choice in
    1|"dualeo")
        wget https://raw.githubusercontent.com/Panhuqusyxh/xray/main/a.sh && bash a.sh
        ;;
    2|"thanh")
        wget https://raw.githubusercontent.com/Panhuqusyxh/xray/main/b.sh && bash b.sh
        ;;
    *)
        echo "Chọn không hợp lệ. Mặc định sẽ chọn dualeo."
        wget https://raw.githubusercontent.com/Panhuqusyxh/xray/main/a.sh && bash a.sh
        ;;
esac
