# docker installation(amazon linux)
````
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker
sudo chmod 777 /var/run/docker.sock
````
