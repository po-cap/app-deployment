
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
.PHONY: ping check deploy managed_node prod-deploy select-env current-env edit-secret view-secret help

ping:
	ansible -i $(INVENTORY) servers -m ping --ask-vault-pass

check:
	ansible-playbook -i $(INVENTORY) deploy.yml --check --diff --ask-vault-password

deploy:
	ansible-playbook -i $(INVENTORY) deploy.yml --ask-vault-pass

managed_node:
	ansible-playbook -i $(INVENTORY) managed_node.yml --ask-vault-pass

prod-confirm:
	@echo -n "Are you sure you want to deploy to PRODUCTION? [y/N] " && read ans && [ $${ans:-N} = y ]

prod-deploy: prod-confirm
	ENV=production $(MAKE) deploy

# 變更 ENV
select-env:
	@echo "Select environment:"; \
	echo "1) development"; \
	echo "2) production"; \
	read -p "Enter choice (1-2): " choice; \
	case "$$choice" in \
		1) export ENV=development;; \
		2) export ENV=production;; \
		*) echo "Invalid choice"; exit 1;; \
	esac

# 查看當前 ENV
current-env:
	@echo "Current ENV is: $(ENV)"

edit-secret:
	ansible-vault edit ./inventories/$(ENV)/group_vars/all/secrets.yml

view-secret:
	ansible-vault edit ./inventories/$(ENV)/group_vars/all/secrets.yml

help:
	@echo "Available targets:"
	@echo "  deploy       - 部署到當前環境 (預設: development)"
	@echo "  check        - 乾跑測試"
	@echo "  ping         - 測試所有主機連線"
	@echo "  edit-secret   - 編輯 secret.yml"
	@echo "  view-secret   - 查看 secret.yml"
	@echo ""
	@echo "環境變數:"
	@echo "  ENV=production - 指定操作環境"