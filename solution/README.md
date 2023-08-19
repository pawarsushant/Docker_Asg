#Commands (post setting-up new EC2 instance in AWS)

1. Installling docker, docker compose & git
```sh
sudo su --- all below commands executed as a root user.
yum update
yum info docker
yum install docker -y
yum install python3-pip -y
pip3 install docker-compose
systemctl enable docker.service
systemctl start docker.service
yum install git -y
```

2. verifying successful installations 
```sh
systemctl status docker.service	
docker version
docker-compose version
git version
```

3. Creating directory & initialise git
```sh
mkdir mygit
cd mygit/
git init
```

4. Pull the specified docker images & verify:
```sh
docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.22.0
docker images
```

5. Clone the specified repo:
```sh
git clone  https://github.com/infracloudio/csvserver.git
```

6. Run the docker container inside solution directory:
```sh
cd csvserver/solution/
docker run -di infracloudio/csvserver:latest
```

7. Check if the docker container is running or not.
```sh
docker ps
```

8. If the docker container is not showing as running, check the status
```sh
docker ps -a
```

9. Check the logs and see what is the error:
```sh
docker logs 38ab599a6cc2
```

10. Create required shell script & make it executable
```sh
touch gencsv.sh
chmod +x gencsv.sh
```

11. Run the cotainer by mouting the inputfile path
```sh
docker run -div /home/ec2-user/mygit/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest
```

12. Login to the container
```sh
docker exec -it d7fa5e51623a /bin/bash
```

13. Check the port
```sh
netstat -tlnp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver
```

14. Stop the running container
```sh
docker stop d7fa5e51623a 
```

15. Run the container with specific port & envvironment variable mapping 
```sh
docker run -div  /home/ec2-user/mygit/csvserver/solution/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER='Orange' infracloudio/csvserver:latest
```

16. Verify if application is accesible at localhost 
```sh
curl localhost:9393
```

17. Configure existing AWS instance's Security -> Security Groups -> Inbound rules with 9393 port & TCP protocol for all IP range. So deployed application can be accesible from local system.
