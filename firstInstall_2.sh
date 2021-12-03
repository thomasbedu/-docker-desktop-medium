# Pre-requisite have virtual box installed and working (cf firstinstall_1.sh)

# Install Vagrant and the vbguest plugin to manage VirtualBox Guest Additions on the VM
brew install vagrant
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-disksize

# Install Docker CLI
brew install docker
brew install docker-compose

# Spin up the machine
vagrant up

# Save IP to a hostname
echo "192.168.63.4 docker.local" | sudo tee -a /etc/hosts > /dev/null

# Tell Docker CLI to talk to the VM
export DOCKER_HOST=tcp://docker.local:2375

# Optionally add it to your shell so don't need to repeat everytime
echo "export DOCKER_HOST=tcp://docker.local:2375" | tee -a ~/.zshrc > /dev/null

# Test
docker run hello-world