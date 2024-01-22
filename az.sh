#!/bin/bash

# Kiểm tra xem người dùng hiện tại có phải là root không
if [ "$EUID" -ne 0 ]; then
    echo "Bạn không đang ở root, hãy đăng nhập vào tài khoản root để thực hiện lệnh này."
    exit 1
fi

# Dưới đây, bạn có thể đặt các lệnh mà bạn muốn chạy khi đang ở root.
# Ví dụ:
echo "Bạn đang ở root. Các lệnh sau đây chỉ thực hiện khi bạn đang ở root."
# Thêm các lệnh bạn muốn thực hiện sau đây

