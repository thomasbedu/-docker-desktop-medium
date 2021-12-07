# Install VirtualBox
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack

# You will need here to authorize Oracle Virtual Box on your mac

# Install Vagrant
brew install vagrant
# vbguest plugin to manage VirtualBox Guest Additions on the VM
vagrant plugin install vagrant-vbguest
# disksize plugin to manage VirtualBox disk size on the VM
vagrant plugin install vagrant-disksize

# Install Docker CLI
brew install docker
brew install docker-compose