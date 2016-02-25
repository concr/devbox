help:
	@echo ""
	@echo "make devbox ........ run devbox-playbook from ansible-vm"
	@echo "make devbox-local .. run devbox-playbook from local machine"
	@echo ""

devbox: couple sync-playbook ansible-remote

couple:
	ssh vagrant@10.10.10.4 'exit'
	ssh vagrant@10.10.10.5 'exit'
	vagrant ssh ansible -c "ssh devbox 'exit'"
	vagrant ssh devbox -c "ssh ansible 'exit'"

sync-playbook:
	@rsync -avW --delete --exclude "*.dist" prov-devbox vagrant@10.10.10.4:/home/vagrant

ansible-remote:
	@vagrant ssh ansible -c "cd prov-devbox && ansible-playbook devbox.yml -i inventory/hosts"

devbox-local: couple ansible-local

ansible-local:
	@cd prov-devbox && ansible-playbook devbox.yml -i inventory/hosts
