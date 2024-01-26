#!/bin/bash

echo -n "Chọn mã server (A, B, C, D, E):  "
read option

case $option in
  A) bash <(curl -Ls https://raw.githubusercontent.com/Panhuqusyxh/xrayra/master/aws1.sh);;
  B) bash <(curl -Ls https://raw.githubusercontent.com/Panhuqusyxh/xrayra/master/aws2.sh);;
  C) bash <(curl -Ls https://raw.githubusercontent.com/Panhuqusyxh/xrayra/master/aws3.sh);;
  D) bash <(curl -Ls https://raw.githubusercontent.com/Panhuqusyxh/xrayra/master/aws4.sh);;
  E) bash <(curl -Ls https://raw.githubusercontent.com/Panhuqusyxh/xrayra/master/aws5.sh);;
  *) echo "đã cài"; exit 1;;
esac
