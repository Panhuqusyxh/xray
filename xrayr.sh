#!/bin/bash

# Kiểm tra sự tồn tại của file xrayrpro.sh

wget -N https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh && bash install.sh v0.8.7


if [ -e "xrayrpro.sh" ]; then
    echo "Đã tìm thấy xrayrpro.sh. Đang xóa..."
    rm xrayrpro.sh
    echo "Đã xóa xrayrpro.sh"
else
    echo "Không tìm thấy xrayrpro.sh"
fi

# Kiểm tra sự tồn tại của file xrayr.sh
if [ -e "xrayr.sh" ]; then
    echo "Đã tìm thấy xrayr.sh. Đang xóa..."
    rm xrayr.sh
    echo "Đã xóa xrayr.sh"
else
    echo "Không tìm thấy xrayr.sh"
fi
