#!/bin/bash

######################################################################
# 在這裡，會用一個壓縮工具
######################################################################

# 歸檔目錄 (根據需要修改)
ARCHIVE_DIR="{{ archive_dir }}"

# 創建按日期分類的子目錄
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
TARGET_DIR="${ARCHIVE_DIR}/${YEAR}/${MONTH}/${DAY}"

# 確保目標目錄存在
mkdir -p "${TARGET_DIR}"

# 把 wal 檔案壓縮後，後檔歸檔 directory 內
gzip -9 -c "${ARCHIVE_DIR}" > "${TARGET_DIR}/$(basename "$1").gz"

# 歸檔 WAL 檔案
# cp "$1" "${TARGET_DIR}/$(basename "$1")"

# 返回成功狀態
exit 0