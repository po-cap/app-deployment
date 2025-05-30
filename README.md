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