#!/bin/bash

######################################################################
# 使用 pg_dump 對數據庫做備份
######################################################################

echo "請選擇一個選項:"
echo "1) 備份資料表結構和資料"
echo "2) 僅備份資料表結構"
echo "3) 僅備份資料"

read -p "請輸入選項 (1/2/3): " choice
read -p "要備份哪個數據庫: " DB_NAME
read -p "數據庫IP: " DB_IP
read -p "數據庫PORT: " DB_PORT
read -p "用戶名稱: " DB_USER

case $choice in
    1)  
        echo "結構 + 資料..."
        pg_dump -U ${DB_USER} -h ${DB_IP} -p ${DB_PORT} -Fc ${DB_NAME} | gzip -6 > ${DB_NAME}.dump.gz
        ;;
    2)  
        echo "結構..."
        pg_dump -U ${DB_USER} -h ${DB_IP} -p ${DB_PORT} -Fc --schema-only ${DB_NAME} | gzip -6 > ${DB_NAME}.dump.gz
        ;;
    3)
        echo "資料..."
        pg_dump -U ${DB_USER} -h ${DB_IP} -p ${DB_PORT} -Fc --schema-only ${DB_NAME} | gzip -6 > ${DB_NAME}.dump.gz
        ;;
    *)
        echo "無效的選項，請輸入 1, 2, 或 3"
        ;;
esac