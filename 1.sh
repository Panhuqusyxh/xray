#!/bin/bash

# Tìm và xóa file 1.sh, a.sh, b.sh nếu tồn tại
files_to_delete=("1.sh" "a.sh" "b.sh")

for file in "${files_to_delete[@]}"; do
    if [ -e "$file" ]; then
        rm "$file" >/dev/null 2>&1  # Xóa file mà không hiển thị output
    fi
done



read -p "
Chọn tên người dùng 
1: dualeo 
2: thanh 
Enter để sử dụng mặc định dualeo
: " choice

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
