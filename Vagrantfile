
#Based on this directory structure
#|-- Vagrantfile
#|-- provisioning
#|   |-- group_vars
#|           |-- all
#|   |-- roles
#|           |-- bar
#|           |-- foo
#|   |-- playbook.yml


#NOTE: Intellj/jetbrains does not build all boxes from it's best to run vagrant command from the terminal.
# This is due provision occuring after first box is up instead of ensure all boxes are up.

#####GLOBAL CONFIG########

VAGRANT_VERSION = 2

#bridge interface and Ip space
BRIDGE_NAME = "wlp3s0"
BRIDGE_NET="192.168.1."
# Prefix for Internal Network
INTERNAL_NET="192.168.15."
# The domain that we will use for the entire site
DOMAIN="" # Warning causes SSH connect issue at build ex: .sample.com

#Set the vagrant hostname and corresponding ansible playbook


ROOT_PASSWORD = "root"
UBUNTU_PASSWORD = "password" # default password for that is set at build time ubuntu NOTE: do not change useless needed

ROOT_SSH_ACCESS = "yes" # allow root ssh  # not working


## For single hostname vagrant provision {{host name}}
## all host vagrant provision


####HOST CONFIGS###########

HOSTNAME_1 = "web"
HOSTNAME_1_DISABLE = false
HOSTNAME_1_PLAYBOOK = "provisioning/web-playbook.yml"
DISTRO_B1 = "ubuntu/xenial64"
VERSION_B1 = "20170626.0.0"
RAM_B1 = 2048
PORT_FOWARD_1 = [8080,8080,5005,5005,1099,1099,8009,8009]   #Vagrant box port first then local host port



HOSTNAME_2 = "db"
HOSTNAME_2_DISABLE = false
HOSTNAME_2_PLAYBOOK = "provisioning/db-playbook.yml"
DISTRO_B2 = "ubuntu/xenial64"
VERSION_B2 = "20170626.0.0"
RAM_B2 = 1000
PORT_FOWARD_2 = [3306,3306]


HOSTNAME_3 = ""
HOSTNAME_3_PLAYBOOK = ""
HOSTNAME_3_DISABLE = true
DISTRO_B3 = "ubuntu/xenial64"
VERSION_B3 = "20170626.0.0"
RAM_B3 = 1000
PORT_FOWARD_3 = [80,8082]





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
    {
        :hostname => HOSTNAME_3 + DOMAIN,
        :ip => BRIDGE_NET + "152",
        :ip_int => INTERNAL_NET+ "152",
        :ram => RAM_B3,
        :main_distro => DISTRO_B3,
        :box_version => VERSION_B3,
        :disable => HOSTNAME_3_DISABLE,
        :port_forward => PORT_FOWARD_3,

    },


]


#Could not get the next command in ruby to work working in Vagrant.configure(2)
servers.each do |machine|
  if machine[:disable]
    servers.delete(machine)
  end
end


#(machine[:port_forward].length).step(2) do |it|
#  node.vm.network "forwarded_port", guest: machine[:port_forward][0], host: machine[:port_forward][7]
#end


Vagrant.configure(VAGRANT_VERSION) do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:main_distro]
      node.vm.box_version = machine[:box_version]
      node.vm.usable_port_range = (2200..2250)
      node.vm.hostname = machine[:hostname]
      if machine[:port_forward]
      node.vm.network "forwarded_port", guest: machine[:port_forward][0], host: machine[:port_forward][1]
      if machine[:port_forward][2]
        node.vm.network "forwarded_port", guest: machine[:port_forward][2], host: machine[:port_forward][3]
      end
      if machine[:port_forward][4]
        node.vm.network "forwarded_port", guest: machine[:port_forward][4], host: machine[:port_forward][5]
      end
      if machine[:port_forward][6]
        node.vm.network "forwarded_port", guest: machine[:port_forward][6], host: machine[:port_forward][7]
      end
      end
      node.vm.network "public_network", ip: machine[:ip], bridge: BRIDGE_NAME # not working at this time
      node.vm.network "private_network", ip: machine[:ip_int], virtualbox__intnet: "intnet"

      node.vm.provider "virtualbox" do |setup|
        setup.name = machine[:hostname]
        setup.memory = machine[:ram]
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



        config.vm.provision "shell" do |s|
          s.inline = 'echo "root:$1" | sudo chpasswd; echo "ubuntu:$2" | sudo chpasswd'
          s.args   = [ROOT_PASSWORD,UBUNTU_PASSWORD]
        end



      #args is not working
      config.vm.provision "shell" do |s|
        s.inline = 'sed -i -e "/^PermitRootLogin/s/^.*$/PermitRootLogin yes/" /etc/ssh/sshd_config; service sshd restart'
        s.args   = [ROOT_SSH_ACCESS]
      end



    end
  end
  end



