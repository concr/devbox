Vagrant.configure(2) do |config|

  # Vanilla Debian 8 "Jessie"
  config.vm.box = "debian/jessie64"

  config.vm.box_check_update = true
  config.vm.hostname = "devbox.local"
  config.vm.network "private_network", ip: "10.10.10.5"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "4096"
    vb.cpus = "4"
  end

  # http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
#  config.vm.provision "fix-no-tty", type: "shell" do |s|
#    s.privileged = false
#    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
#  end

#  config.vm.provision "ssh-copy-id", type: "shell" do |s|
#    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
#    s.inline = <<-SHELL
#      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
#      #echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
#    SHELL
#  end

  config.vm.provision "ansible" do |a|
    a.playbook = "./ansible/devbox.yml"
    a.inventory_path = "./ansible/inventory/hosts"
    a.limit = config.vm.hostname
    a.verbose = false
  end

end
