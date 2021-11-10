# Description
This repo is a demo to start a [MCMS](https://gitee.com/mingSoft/MCMS) web service.
this repo only shows the deployment of MCMS with docker and docker-compose,
you can use to build your own docker image, start services.

# Usage
You need to install the docker and docker-compose first to use this repo,
My work environment as followed:
```
$ docker version
Client: Docker Engine - Community
 Version:           20.10.7
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        f0df350
 Built:             Wed Jun  2 11:56:24 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.7
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       b0f5bc3
  Built:            Wed Jun  2 11:54:48 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.6
  GitCommit:        d71fcd7d8303cbf684402823e425e9dd2e99285d
 runc:
  Version:          1.0.0-rc95
  GitCommit:        b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
$ docker-compose version
docker-compose version 1.27.4, build 40524192
docker-py version: 4.3.1
CPython version: 3.7.7
OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019

```

## Change the default variables in .env file
There are servel variables you may need to modify:
```
MCMS_VERSION=5.2.4
MYSQL_HOST=mysql
MYSQL_PORT=3306
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=mcms
MYSQL_USER=mcms
MYSQL_PASSWORD=password
```
Both the mcms and mysql containers need these variables to startup.

## Build the docker image
```
export MCMS_VERSION=5.2.4
docker build . -t mcms:${MCMS_VERSION} --build-arg MCMS_VERSION=${MCMS_VERSION}
```

## Start up the services
```
docker-compose up -d
```

## Access the web service
Url: http://Your IP address:8080/ms/login.do  
Default admin username: `msopen`  
Default admin password: `msopen`

# Notice
The MCMS database need to init with a sql file when the first time startup,  
please make sure you have the matched init sql under the `init-sqls` directory.  
you can find the offical sql files in [here](https://gitee.com/mingSoft/MCMS/tree/master/doc), if this repo does not contain the  
specifed version, please download manully and save to `init-sqls` directory.

