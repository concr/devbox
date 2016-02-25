help:
	@echo ""
	@echo "make devbox ........ run devbox-playbook from ansible-vm"
	@echo "make devbox-local .. run devbox-playbook from local machine"
	@echo ""

devbox: sync-playbook ansible-remote

sync-playbook:
	@rsync -avW --delete prov-devbox vagrant@10.10.10.4:/home/vagrant

ansible-remote:
	@vagrant ssh ansible -c "cd prov-devbox && ansible-playbook devbox.yml -i inventory/hosts"

devbox-local:
	@cd prov-devbox && ansible-playbook devbox.yml -i inventory/hosts
