# savr - super ansible vagrant runner

## Needs

[VirtualBox](https://www.virtualbox.org/wiki/Downloads), [Vagrant](https://www.vagrantup.com/downloads.html), [Ansible](http://docs.ansible.com/ansible/intro_installation.html) or if you're on a Mac with [homebrew](http://brew.sh) and [caskroom](http://caskroom.io):
<pre>
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
brew install ansible
</pre>

## Prerequisites

You have to edit the `Vagrantfile`
<pre>
config.vm.hostname = "devbox.local"
config.vm.network "private_network", ip: "10.10.10.5"
</pre>

... a matching entry in `ansible/inventory/hosts`
<pre>
devbox.local ansible_host=10.10.10.5 ansible_user=vagrant
</pre>

... and following lines in your local `/etc/hosts` for the default vhosts
<pre>
10.10.10.5 db.admin.devbox.local
10.10.10.5 info.admin.devbox.local
10.10.10.5 bench.admin.devbox.local
10.10.10.5 test.website.devbox.local
10.10.10.5 test.project.devbox.local
</pre>

To configure PHP versions to compile and webserver ports, edit `devbox.yml`.

## Setup/Start

<pre>
vagrant up
</pre>

## Maintenance

<pre>
vagrant provision
</pre>

## Good to know

If you want to setup a new vhost like `hello.website.devbox.local` just use the
`createworkspace` tool within your VM.

<pre>
createworkspace website hello
</pre>

## PHP

To select your PHP version on PHPBrew do following steps in your VM:
<pre>
phpbrew switch php-7.0.3 (or some other version)
phpbrew fpm start
</pre>

If you want to change the version, please stop the fpm before switching!
<pre>
phpbrew fpm stop
phpbrew switch php-5.6.18
phpbrew fpm start
</pre>
