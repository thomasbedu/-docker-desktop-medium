# Install Docker
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release net-tools software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Configure Docker to listen on a TCP socket
mkdir /etc/systemd/system/docker.service.d
echo '[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --containerd=/run/containerd/containerd.sock' | tee /etc/systemd/system/docker.service.d/docker.conf > /dev/null
echo '{
  "hosts": ["fd://", "tcp://0.0.0.0:2375"]
}' | tee /etc/docker/daemon.json > /dev/null
systemctl daemon-reload
systemctl restart docker.service

# Add docker.pictet.aws certificate
mkdir -p /etc/docker/certs.d/docker.pictet.aws/
openssl s_client -showcerts -connect docker.pictet.aws:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /etc/docker/certs.d/docker.pictet.aws/ca.crt
# Add docker.pictet.io certificate
mkdir -p /etc/docker/certs.d/docker.pictet.io/
openssl s_client -showcerts -connect docker.pictet.io:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /etc/docker/certs.d/docker.pictet.io/ca.crt

# Install portainer for gui addict : https://docker.local:9443
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest