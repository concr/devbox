# savr - super ansible vagrant runner

## Needs

[VirtualBox](https://www.virtualbox.org/wiki/Downloads), [Vagrant](https://www.vagrantup.com/downloads.html), [Ansible](http://docs.ansible.com/ansible/intro_installation.html) or if you're on a Mac with [homebrew](http://brew.sh) and [caskroom](http://caskroom.io):
<pre>
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
brew install ansible
</pre>

## Setup/Start

Copy `prov-devbox/devbox.yml.dist` to `prov-devbox/devbox.yml` and configure it
as you want.

### Case 1: __without__ local ansible installation (e.g. Windows)

Start an _ansible_- and _devbox_-VM, then do the provision from the _ansible_-VM.

<pre>
vagrant up
make devbox
</pre>

Some backround: `make devbox` copies the ansible-playbook and its roles to the
_ansible_-VM and runs it with a remote-ssh command from there. So the ansible
runner connects from within the _ansible_-VM directly to the _devbox_-VM. That's
the trick, why this case doesn't need a local ansible installation.

### Case 2: __with__ local ansible installation (e.g. OSX, Linux)

Start a _devbox_-VM and do the provision from your local machine.

<pre>
vagrant up devbox
make devbox-local
</pre>

## Post installation

Add following lines to your local `/etc/hosts` for the default vhosts

<pre>
10.10.10.5 db.admin.devbox.local
10.10.10.5 info.admin.devbox.local
10.10.10.5 bench.admin.devbox.local
10.10.10.5 test.website.devbox.local
10.10.10.5 test.project.devbox.local
</pre>

And do following in your `devbox`-VM, to start the php-fpm:

<pre>
phpbrew switch php-7.0.3 (or your prefered/installed version)
phpbrew fpm start
</pre>

## Good to know

### Configure webserver/fpm ports and PHP versions

Have a look at the `ansible/devbox.yml` ...

### SSH

Use `vagrant ssh ansible` (or `... devbox`) to connect to you machine.

If you just want to use your typical `ssh`-command, do the following:

<pre>
vagrant ssh-config >> ~/.ssh/config
</pre>

This command puts a host alias to your ssh-config. From that moment on, you can
connect to you machine(s) with a simple `ssh ansible` (or `... devbox`).

### Workspaces

If you want to setup a new vhost like `hello.website.devbox.local` just use the
`createworkspace` tool within your VM.

<pre>
createworkspace website hello
</pre>

### PHP

If you want to change the version, please stop the fpm before switching!

<pre>
phpbrew fpm stop
phpbrew switch php-5.6.18
phpbrew fpm start
</pre>
