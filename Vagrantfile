# -*- mode: ruby -*-
# vi: set ft=ruby :

CPUS = '2'
MEMORY = '5120'
DISK_SIZE = '50GB'
FROM_VAGRANT_BOX = 'ubuntu/focal64'

# Official Ubuntu 21.04 Hirsute Hippo
# config.vm.box = "ubuntu/hirsute64"
# Official Ubuntu 18.04 LTS Bionic Beaver
# config.vm.box = "ubuntu/bionic64"

Vagrant.configure('2') do |config|
  # Official Ubuntu 20.04 LTS Focal Fossa
  config.vm.box = FROM_VAGRANT_BOX
  config.vm.hostname = 'docker.local'
  config.vm.network 'private_network', ip: '192.168.63.4'
  config.vm.hostname = "docker.local"
  config.vm.network 'forwarded_port', guest: 2375, host: 2375, id: 'dockerd'
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'ubuntu-docker'
    vb.memory = MEMORY
    vb.cpus = CPUS
  end
  config.disksize.size = DISK_SIZE
  config.vm.synced_folder "/Users", "/Users"
  config.vm.provision 'shell', path: 'provision/provision.sh'

  # Configuration for Port Forwarding
  # Uncomment or add new ones here as required
  # config.vm.network 'forwarded_port', guest: 6379, host: 6379, id: 'redis'
  # config.vm.network 'forwarded_port', guest: 3306, host: 3306, id: 'mysql'
end
