
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




#bridge interface and Ip space
BRIDGE_NAME = "wlp3s0"
BRIDGE_NET="192.168.1."
# Prefix for Internal Network
INTERNAL_NET="192.168.15."
# The domain that we will use for the entire site
DOMAIN="" # Warning causes SSH connect issue at build ex: .sample.com

#Set the vagrant hostname and corresponding ansible playbook

#Note: When using vagrant provision, change the variable disable if you do not want to provision again
# ex. HOSTNAME_3_DISABLE = true

#Note: vagrant ssh will not work for boxes that are disable, you will have to re enable it again to gain ssh access

ROOT_PASSWORD = "root"
UBUNTU_PASSWORD = "ubuntu"


HOSTNAME_1 = "web"
HOSTNAME_1_PLAYBOOK = "provisioning/web-playbook.yml"
HOSTNAME_1_DISABLE = false
DISTRO_B1 = "ubuntu/xenial64"
VERSION_B1 = "20170626.0.0"
RAM_B1 = 1000
PORT_FOWARD_1 = [80,8080]   #Vagrant box port first then local host port


HOSTNAME_2 = "db"
HOSTNAME_2_PLAYBOOK = "provisioning/db-playbook.yml"
HOSTNAME_2_DISABLE = false
DISTRO_B2 = "ubuntu/xenial64"
VERSION_B2 = "20170626.0.0"
RAM_B2 = 1000
PORT_FOWARD_2 = false   # set as false if port foward needs to be disabled

# comment out boxes you don't want in the hash array before vagrant up or first build
HOSTNAME_3 = ""
HOSTNAME_3_PLAYBOOK = ""
HOSTNAME_3_DISABLE = true
DISTRO_B3 = "ubuntu/xenial64"
VERSION_B3 = "20170626.0.0"
RAM_B3 = 1000
PORT_FOWARD_3 = [80,8082]   #Vagrant box first then local host port


#NOTE:  ansible.limit = "" #Does not work and the name needs to be set in ansible playbook file ex. - hosts: web


# An array of hashes in which settings are configured for each virtual machine
servers=[
    {
        :hostname => HOSTNAME_1 + DOMAIN,
        :ip => BRIDGE_NET + "150",
        :ip_int => INTERNAL_NET + "150",
        :ram => RAM_B1,
        :main_distro => DISTRO_B1,
        :box_version => VERSION_B1,
        :disable => HOSTNAME_1_DISABLE,
        :port_forward => PORT_FOWARD_1,


    },
    {
        :hostname => HOSTNAME_2 + DOMAIN,
        :ip => BRIDGE_NET + "151",
        :ip_int => INTERNAL_NET+ "151",
        :ram => RAM_B2,
        :main_distro => DISTRO_B2,
        :box_version => VERSION_B2,
        :disable => HOSTNAME_2_DISABLE,
        :port_forward => PORT_FOWARD_2,

    },
    #{
    #    :hostname => HOSTNAME_3 + DOMAIN,
    #    :ip => BRIDGE_NET + "152",
    #    :ip_int => INTERNAL_NET+ "152",
    #    :ram => RAM_B3,
    #    :main_distro => DISTRO_B3,
    #    :box_version => VERSION_B3,
    #    :disable => HOSTNAME_3_DISABLE,
    #    :port_forward => PORT_FOWARD_3,
    #},


]


#Could not get the next command in ruby to work working
# found it best to disable the boxes before vagrant became a
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
      if machine[:port_forward]
      node.vm.network "forwarded_port", guest: machine[:port_forward][0], host: machine[:port_forward][1]
      end
      node.vm.network "public_network", ip: machine[:ip], bridge: BRIDGE_NAME # not working at this time
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

