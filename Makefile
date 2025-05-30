
# variables - 
# ENV:           環境變數 (預設值為 development)
# INVENTORY:     Inventory 文件路徑
# ENVIRONMENTS:  定義所支援的環境
ENV ?= development
INVENTORY := inventories/$(ENV)/hosts.ini
ENVIRONMENTS := development production

# 驗證環境參數
ifeq ($(filter $(ENV),$(ENVIRONMENTS)),)
	$(error Invalid ENV. Must be one of: $(ENVIRONMENTS))
endif

# 常用指令
.PHONY: ping check deploy prod-deploy help

ping:
	ansible -i $(INVENTORY) servers -m ping --ask-vault-password

check:
	ansible-playbook -i $(INVENTORY) deploy.yml --check --diff --ask-vault-password

deploy:
	ansible-playbook -i $(INVENTORY) deploy.yml --ask-vault-pass

prod-confirm:
	@echo -n "Are you sure you want to deploy to PRODUCTION? [y/N] " && read ans && [ $${ans:-N} = y ]

prod-deploy: prod-confirm
	ENV=production $(MAKE) deploy

help:
	@echo "Available targets:"
	@echo "  deploy       - 部署到當前環境 (預設: development)"
	@echo "  check        - 乾跑測試"
	@echo "  ping         - 測試所有主機連線"
	@echo ""
	@echo "環境變數:"
	@echo "  ENV=production - 指定操作環境"