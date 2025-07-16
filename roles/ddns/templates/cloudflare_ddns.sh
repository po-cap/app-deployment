#!/bin/bash

# 配置参数
AUTH_EMAIL="{{ ddns.email }}"     # 你的 Cloudflare 邮箱
AUTH_KEY="{{ ddns.key }}"         # 你的 Cloudflare API 密钥
ZONE_NAME="{{ zone_name }}"       # 你的域名
RECORD_NAME="{{ record_name }}"   # 要更新的记录名
RECORD_TYPE="A"                   # 记录类型

# 获取当前公网 IP
IP=$(curl -s http://ipv4.icanhazip.com)

# 获取区域 ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$ZONE_NAME" \
    -H "X-Auth-Email: $AUTH_EMAIL" \
    -H "X-Auth-Key: $AUTH_KEY" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取记录 ID
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$RECORD_NAME&type=$RECORD_TYPE" \
    -H "X-Auth-Email: $AUTH_EMAIL" \
    -H "X-Auth-Key: $AUTH_KEY" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 更新 DNS 记录
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
    -H "X-Auth-Email: $AUTH_EMAIL" \
    -H "X-Auth-Key: $AUTH_KEY" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"$RECORD_TYPE\",\"name\":\"$RECORD_NAME\",\"content\":\"$IP\",\"ttl\":120,\"proxied\":false}" | jq

# 记录日志
echo "$(date): IP updated to $IP" >> /var/log/cloudflare_ddns.log