Vagrant.configure("2") do |config|

  config.vm.define "ansible" do |ans|
    ans.ssh.forward_agent = true
    ans.ssh.insert_key = false

    # Ubuntu 12.04 x64 minimal install
    ans.vm.box = "geerlingguy/ubuntu1204"
    ans.vm.box_check_update = true
    ans.vm.hostname = "ansible.local"
    ans.vm.network "private_network", ip: "10.10.10.4"
    ans.vm.synced_folder ".", "/vagrant", disabled: true

    ans.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "512"
      vb.cpus = "2"
    end

    # http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
    ans.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end

    ans.vm.provision "shell", inline: "apt-get update", privileged: true
    ans.vm.provision "shell", inline: "apt-get install -y build-essential python-software-properties openssh-server", privileged: true
    ans.vm.provision "shell", inline: "apt-add-repository -y ppa:ansible/ansible", privileged: true
    ans.vm.provision "shell", inline: "apt-get update", privileged: true
    ans.vm.provision "shell", inline: "apt-get install -y ansible", privileged: true
    ans.vm.provision "shell", inline: "apt-get autoremove", privileged: true
    ans.vm.provision "shell", inline: "apt-get autoclean", privileged: true
    #ans.vm.provision "file", source: "devbox-playbook", destination: "/home/vagrant/devbox-playbook"
  end

  config.vm.define "devbox" do |dev|
    dev.ssh.forward_agent = true
    dev.ssh.insert_key = false

    # Vanilla Debian 8 "Jessie"
    dev.vm.box = "debian/jessie64"
    dev.vm.box_check_update = true
    dev.vm.hostname = "devbox.local"
    dev.vm.network "private_network", ip: "10.10.10.5"
    dev.vm.synced_folder ".", "/vagrant", disabled: true
    dev.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "4096"
      vb.cpus = "4"
    end

  end

end
