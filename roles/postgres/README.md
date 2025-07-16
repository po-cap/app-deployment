Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).


## 說明
除非把 Data Directry 的權限改為 750，不然，把其他用戶加入 postgres 組也沒意義。


## Log

### Where to log

* log_destination (stderr, syslog, csvlog, eventlog)
* logging_collector (on/off)
* log_directory # usa a custom partition
* log_filename # postgresql-%Y-%m-%d_%H%M%S.log
* log_file_mode (0600)
* log_rotation_age (1 day)
* log_rotation_size (10MB)
* log_trucae_on_rotation (on/off)

### What to log

* log_min_messages
* log_min_error_statement


* log_min_duration_statement
    * Logs queries that are condisered "slow" in ypur application
    * dose not log parameters
* log_statement ((none, ddl, mod, all, default 是 all))
    * logs the statement BEFORE the query is excuted
    * logs parameters


* log_min_duration_sample
* log_statement_sample_rate
* log_transaction_sample_rate

### When to log
* log_min_messages
* log_min_error_statement

| name | control range | content | default | in production | when |
| ----------------------- | ---------------- | --------------------- | ------- | ------------- | ---- | 
| log_min_messages        | 所有日志消息       | 错误/警告/通知等消息本身  | warning | warning 或 error |  获取全面的系统状态信息
| log_min_error_statement | 仅导致错误的SQL语句 | 引发错误的原始SQL语句文本 | error | error 或 fatal |追踪导致问题的具体SQL