# docker installation(amazon linux)
````
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker
sudo chmod 777 /var/run/docker.sock
````
# docker Archiecture
<img width="801" height="401" alt="image" src="https://github.com/user-attachments/assets/788f894f-bc58-480c-b327-e577161813f9" />

## pull image from dockerhub
````
docker pull nginx
````
````
docker pull abhipraydh96/yoga
````
````
docker pull abhipraydh96/coffee
````
## list docker images
````
docker images
````
## create container from image
````
docker run -itd -p 80:80 nginx
````
## list running container
````
docker ps
````
## detailed info of container
````
docker inspect <containerID>  #change cotainer id of your cont
````
## login into docker cont
````
docker exec -it <containerID>  /bin/bash
````
