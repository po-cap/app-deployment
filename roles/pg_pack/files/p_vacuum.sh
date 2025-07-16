#!/bin/bash

# 在使用前，確保在 database 做了 CREATE EXTENSION pg_repack;
# 正在進行中時，想查看進度用
#   SELECT * FROM pg_stat_progress_repack;

printf "請輸入 Database 名稱"; read DATABASE;
printf "請輸入 Table 名稱"; read TABLE;

# 使用 4個 worker 進程
pg_repack -j 4 -U postgres -d DATABASE -t TABLE
