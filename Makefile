help:
	@echo ""
	@echo "make init .......... crossconnect between ansible-vm and devbox"
	@echo ""
	@echo "make devbox ........ run devbox-playbook from ansible-vm"
	@echo "make devbox-local .. run devbox-playbook from local machine"
	@echo ""

init: handshake

handshake:
	vagrant ssh ansible -c "chmod 500 .ssh/id_rsa; ssh devbox 'exit'"
	vagrant ssh devbox -c "chmod 500 .ssh/id_rsa; ssh ansible 'exit'"

devbox: ansible-remote

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
