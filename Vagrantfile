
# array approach based on:
#http://sysadm.pp.ua/linux/sistemy-virtualizacii/vagrantfile.html

#Based on this directory structure
#|-- Vagrantfile
#|-- provisioning
#|   |-- group_vars
#|           |-- all
#|   |-- roles
#|           |-- bar
#|           |-- foo
#|   |-- playbook.yml

MAIN_DISTRO = "ubuntu/xenial64"
BOX_VERSION = "20170626.0.0"
RAM = 1000

ROOT_PASSWORD = "testtest"
UBUNTU_PASSWORD = "ubuntu"


#bridge interface and Ip space
BRIDGE_NAME = "wlp3s0"
BRIDGE_NET="192.168.1."
# Prefix for Internal Network
INTERNAL_NET="192.168.15."
# The domain that we will use for the entire site
DOMAIN="" # Warning causes SSH connect issue at build ex: .sample.com

#Set the vagrant hostname and corresponding ansible playbook

#Note: When using vagrant provision, change the variable disable if you do not want to provision again or
#Note: vagrant ssh will b
# ex. HOSTNAME_3_DISABLE = true

HOSTNAME_1 = "web"
HOSTNAME_1_PLAYBOOK = "provisioning/web-playbook.yml"
HOSTNAME_1_DISABLE = false

HOSTNAME_2 = "db"
HOSTNAME_2_PLAYBOOK = "provisioning/db-playbook.yml"
HOSTNAME_2_DISABLE = true

# comment out boxes you don't want in the hash array before vagrant up or first build
HOSTNAME_3 = ""
HOSTNAME_3_PLAYBOOK = ""
HOSTNAME_3_DISABLE = true

#NOTE:  ansible.limit = "" #Does not work and the name needs to be set in ansible playbook file ex. - hosts: web


# An array of hashes in which settings are configured for each virtual machine
servers=[
    {
        :hostname => HOSTNAME_1 + DOMAIN,
        :ip => BRIDGE_NET + "150",
        :ip_int => INTERNAL_NET + "150",
        :ram => RAM,
        :main_distro => MAIN_DISTRO,
        :box_version => BOX_VERSION,
        :disable => HOSTNAME_1_DISABLE

    },
    {
        :hostname => HOSTNAME_2 + DOMAIN,
        :ip => BRIDGE_NET + "151",
        :ip_int => INTERNAL_NET+ "151",
        :ram => RAM,
        :main_distro => MAIN_DISTRO,
        :box_version => BOX_VERSION,
        :disable => HOSTNAME_2_DISABLE
    },
    #{
    #    :hostname => HOSTNAME_3 + DOMAIN,
    #    :ip => BRIDGE_NET + "152",
    #    :ip_int => INTERNAL_NET+ "152",
    #    :ram => RAM,
    #    :main_distro => MAIN_DISTRO,
    #    :box_version => BOX_VERSION,
    #    :disable => HOSTNAME_3_DISABLE
    #},


]

servers.each do |machine|
  if machine[:disable]
    servers.delete(machine)
  end
  end

Vagrant.configure(2) do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:main_distro]
      node.vm.box_version = machine[:box_version]
      node.vm.usable_port_range = (2200..2250)
      node.vm.hostname = machine[:hostname]
      node.vm.network "public_network", ip: machine[:ip], bridge: BRIDGE_NAME
      node.vm.network "private_network", ip: machine[:ip_int], virtualbox__intnet: "intnet"


        # added as a fix to https://github.com/mitchellh/vagrant/issues/7350
        config.vm.provision "shell" do |s|
          s.inline = 'echo "root:$1" | sudo chpasswd; echo "ubuntu:$2" | sudo chpasswd'
          s.args   = [ROOT_PASSWORD,UBUNTU_PASSWORD]
        end



        config.vm.provision "ansible_local" do |ansible|
          if node.vm.hostname == HOSTNAME_1
            ansible.playbook = HOSTNAME_1_PLAYBOOK
          end
          if node.vm.hostname == HOSTNAME_2
            ansible.playbook = HOSTNAME_2_PLAYBOOK
          end
          if node.vm.hostname == HOSTNAME_3
            ansible.playbook = HOSTNAME_3_PLAYBOOK
          end
        end
      end
    end
  end

