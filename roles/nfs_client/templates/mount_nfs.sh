#!/bin/bash
{% for item in nfs_dirs %}
mount -t nfs -o rw,nosuid,noexec {{ server_ip }}:{{ item.server_path }} {{ item.client_path }}
{% endfor %}

