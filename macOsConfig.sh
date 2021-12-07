# Save IP to a hostname
echo "192.168.63.4 docker.local" | sudo tee -a /etc/hosts > /dev/null

# Tell Docker CLI to talk to the VM
export DOCKER_HOST=tcp://docker.local:2375

# Optionally add it to your shell so don't need to repeat everytime
echo "export DOCKER_HOST=tcp://docker.local:2375" | tee -a ~/.zshrc > /dev/null

# Test
docker run hello-world