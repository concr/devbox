help:
	@echo ""
	@echo "make init .......... crossconnect between ansible-vm and devbox"
	@echo ""
	@echo "make devbox ........ run devbox-playbook from ansible-vm"
	@echo "make devbox-local .. run devbox-playbook from local machine"
	@echo ""

init: handshake

handshake:
	ssh vagrant@10.10.10.4 'exit'
	ssh vagrant@10.10.10.5 'exit'
	vagrant ssh ansible -c "ssh devbox 'exit'"
	vagrant ssh devbox -c "ssh ansible 'exit'"

devbox: sync-playbook ansible-remote

sync-playbook:
	@rsync -avW --delete --exclude "*.dist" provisioning vagrant@10.10.10.4:/home/vagrant

ansible-remote:
ifdef tags
	@vagrant ssh ansible -c "cd provisioning && ansible-playbook devbox.yml -i inventory/hosts -t $(tags)"
else
	@vagrant ssh ansible -c "cd provisioning && ansible-playbook devbox.yml -i inventory/hosts"
endif

devbox-local: ansible-local

ansible-local:
ifdef tags
	@cd provisioning && ansible-playbook devbox.yml -i inventory/hosts -t $(tags)
else
	@cd provisioning && ansible-playbook devbox.yml -i inventory/hosts
endif
