#!/bin/bash

######################################################################
# 恢復期間，到 restore_command 下設定
# restore_command = '/usr/local/bin/pg_unarchive.sh %f %p'
######################################################################

# 一個基本恢復流程中，需要對 conf 檔案更改的部分
#    restore_command = 'cp /path/to/your/wal_archive/%f %p' # 定義如何從歸檔目錄獲取 WAL 文件
#    # 範例：restore_command = 'cp /mnt/pg_archive/%f %p'
#    # %f 是文件名，%p 是 PostgreSQL 期望 WAL 文件被放置到的路徑
#    # 這個命令必須返回 0 成功，非 0 失敗。通常你需要一個腳本來處理文件不存在的情況。
#
#    # 恢復目標（選擇其中一個）
#    # recovery_target_name = 'my_recovery_point' # 恢復到一個命名恢復點
#    # recovery_target_time = '2023-10-27 10:00:00 BST' # 恢復到特定時間點
#    # recovery_target_xid = '12345' # 恢復到特定交易 ID
#    # recovery_target_lsn = '0/16B00000' # 恢復到特定 LSN
#
#    # 恢復目標行為 (可選，但推薦)
#    # recovery_target_action = pause # 恢復到目標後暫停，以便檢查數據
#    # recovery_target_action = shutdown # 恢復到目標後關閉數據庫
#    # recovery_target_action = promote # 恢復到目標後立即提升為主服務器 (用於standby)


# 定義會用到的變數
WAL_FILE=$1
RESTORE_PATH=$2
ARCHIVE_DIR={{ archive_dir }}

# 解压到目标位置
gunzip -c "${ARCHIVE_DIR}/${WAL_FILE}.gz" > "${RESTORE_PATH}"