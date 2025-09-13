ansible-playbook -i inventory/ site.yml -e "env=production"



- hosts: all
  pre_tasks:
    - name: 加载环境变量
      include_vars: "vars/{{ env }}.yml"
  tasks:
    - debug:
        msg: "DB主机: {{ db_host }}"

生成 md5 去 psql 輸入： 
1) SELECT 'md5' || md5('password' || 'username'); 
2) echo -n "usernamepassword" | md5sum


yamllint ~/Desktop/devops/roles/nfs_server/tasks/main.yml 


sudo showmount -e lime


#server {
#    listen 443 ssl;
#    server_name {{ domain }}; 
#
#    ssl_certificate /etc/letsencrypt/live/{{ domain }}/fullchain.pem;
#    ssl_certificate_key /etc/letsencrypt/live/{{ domain }}/privkey.pem;
#
#    ssl_protocols TLSv1.2 TLSv1.3;
#    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256';
#    ssl_prefer_server_ciphers on;
#
#    root /var/www/html;
#
#    location / {
#        root /var/www/html;
#        index index.html;
#        try_files $uri $uri/ =404;
#    }
#}

ansible lint 的配置文件在 ~/.ansible-lint


# 用 nginx 做四層代理給 postgres
```nginx.conf
stream {

    upstream postgres_backend {
        server 192.168.50.57:5432
    }

    server {
        listen 5432 ssl;
        proxy_pass postgres_backend;

        proxy_connect_timeout 1s;
        proxy_timeout 3s;

        # SSL 配置
        ssl_certificate /etc/letsencrypt/live/t8.supojen.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/t8.supojen.com/privkey.pem;

        # SSL 強化設定（Certbot 會產生這個檔案）
        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    }
}
```