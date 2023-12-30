#!/bin/bash

read -p "Nhập tên người dùng (dualeo hoặc thanh): " username

case $username in
    "dualeo")
        wget https://raw.githubusercontent.com/Panhuqusyxh/xray/main/a.sh && bash a.sh
        ;;
    "thanh")
        wget https://raw.githubusercontent.com/Panhuqusyxh/xray/main/b.sh && bash b.sh
        ;;
    *)
        echo "Tên người dùng không hợp lệ."
        ;;
esac
