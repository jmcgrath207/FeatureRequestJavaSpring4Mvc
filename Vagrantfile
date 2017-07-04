

#http://sysadm.pp.ua/linux/sistemy-virtualizacii/vagrantfile.html



MAIN_DISTRO = "ubuntu/xenial64"
BOX_VERSION = "20170626.0.0"
RAM = 1000

#bridge interface and Ip space
BRIDGE_NAME = "wlp3s0"
BRIDGE_NET="192.168.1."
# Prefix for Internal Network
INTERNAL_NET="192.168.15."
# The domain that we will use for the entire site
DOMAIN="" # Warning causes SSH connect issue at build ex: .sample.com


#Based on this directory structure
#|-- Vagrantfile
#|-- provisioning
#|   |-- group_vars
#|           |-- all
#|   |-- roles
#|           |-- bar
#|           |-- foo
#|   |-- playbook.yml


#Set the vagrant hostname and corrpsoning ansible playbook
HOSTNAME_1 = "web"
HOSTNAME_1_PLAYBOOK = "provisioning/web-playbook.yml"

HOSTNAME_2 = "db"
HOSTNAME_2_PLAYBOOK = "provisioning/db-playbook.yml"

HOSTNAME_3 = ""
HOSTNAME_3_PLAYBOOK = ""

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

    },
    {
        :hostname => HOSTNAME_2 + DOMAIN,
        :ip => BRIDGE_NET + "151",
        :ip_int => INTERNAL_NET+ "151",
        :ram => RAM,
        :main_distro => MAIN_DISTRO,
        :box_version => BOX_VERSION,
    },
    #{
    #    :hostname => HOSTNAME_3 + DOMAIN,
    #    :ip => BRIDGE_NET + "152",
    #    :ip_int => INTERNAL_NET+ "152",
    #    :ram => RAM,
    #    :main_distro => MAIN_DISTRO,
    #    :box_version => BOX_VERSION,
    #},


]


Vagrant.configure(2) do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:main_distro]
      node.vm.box_version = machine[:box_version]
      node.vm.usable_port_range = (2200..2250)
      node.vm.hostname = machine[:hostname]
      node.vm.network "public_network", ip: machine[:ip], bridge: BRIDGE_NAME
      node.vm.network "private_network", ip: machine[:ip_int], virtualbox__intnet: "intnet"


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