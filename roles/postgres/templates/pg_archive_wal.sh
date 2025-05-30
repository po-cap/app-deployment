#!/bin/bash

# 歸檔目錄 (根據需要修改)
ARCHIVE_DIR="{{ archive_dir }}"

# 創建按日期分類的子目錄
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
TARGET_DIR="${ARCHIVE_DIR}/${YEAR}/${MONTH}/${DAY}"

# 確保目標目錄存在
mkdir -p "${TARGET_DIR}"

# 歸檔 WAL 檔案
cp "$1" "${TARGET_DIR}/$(basename "$1")"

# 刪除7天前的歸檔
find "${ARCHIVE_DIR}" -type f -name "000*" -mtime +7 -exec rm -f {} \;

# 返回成功狀態
exit 0