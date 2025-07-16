#!/bin/bash

######################################################################
# 使用 pg_restore 對數據庫做恢復
######################################################################

if [ -z "${1}" ]; then
    echo "沒有輸入備份檔案，請輸入備份檔案..."
    return 1 2>/dev/null
fi

read -p "還原到哪個數據庫: " DB_NAME
read -p "連線使用者名稱: " DB_USER


gunzip -k $(basename ${1})
pg_restore -U ${DB_USER} -d ${DB_NAME} $(basename "${1}" | sed 's/\.gz$//')
rm $(basename "${1}" | sed 's/\.gz$//')