# 1. 建立一個目錄來存放憑證
mkdir -p /etc/pgbouncer/certs
chmod 700 /etc/pgbouncer/certs
cd /etc/pgbouncer/certs

# 2. 生成 CA 私鑰 (建議加上密碼)
openssl genrsa -des3 -out ca.key 2048
# 請輸入一個安全的密碼 (passphrase)，並記住它。

# 3. 生成 CA 憑證 (有效期 1 年)
openssl req -new -x509 -days 365 -key ca.key -out ca.crt
# 根據提示輸入資訊。Common Name (CN) 可以是你的組織名稱，例如 "MyCompany CA"。

# 4. 生成 PgBouncer 伺服器的私鑰 (不要加密碼，PgBouncer 啟動時會要求)
openssl genrsa -out pgbouncer_server.key 2048

# 5. 生成 PgBouncer 伺服器的憑證簽署請求 (CSR)
openssl req -new -key pgbouncer_server.key -out pgbouncer_server.csr
# 這裡的 Common Name (CN) **非常重要**！
# 它必須是客戶端連接 PgBouncer 時使用的**主機名或 IP 地址**。
# 例如，如果客戶端會用 'pgbouncer.example.com' 連接，那麼 CN 就設為 'pgbouncer.example.com'。
# 如果客戶端會用 '192.168.1.100' 連接，那麼 CN 就設為 '192.168.1.100'。
# 如果是本地測試，可以是 'localhost' 或 '127.0.0.1'。
# 你也可以在 Subject Alternative Name (SAN) 中添加多個主機名/IP。

# 6. 使用 CA 憑證簽署 PgBouncer 伺服器的憑證 (有效期 1 年)
openssl x509 -req -days 365 -in pgbouncer_server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out pgbouncer_server.crt
# 會提示輸入 CA 私鑰的密碼。