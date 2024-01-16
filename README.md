## Docker file 

> A Dockerfile is used to build a Docker image. Docker images are a lightweight, portable, and executable package that includes everything needed to run a software application, including the code, runtime, libraries, and system tools.

### This Dockerfile creates an image for running Postman/Newman on Alpine Linux.

 **Base Image**
 
```Dockerfile
FROM postman/newman:6.0.0-alpine
```

**Update and Install Dependencies**

```Dockerfile
RUN apk update && \
    apk upgrade && \
    apk add --no-cache curl zip iputils nodejs npm && \
    npm install -g newman-reporter-csvallinone
```

**Set DNS Servers**

Here i set the dns by using bash shell script to edit in resolv.conf file after the image will built 

```Dockerfile
COPY set_dns.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/set_dns.sh >> for giving the script file execute permission to be runnable 
```

**Remove Installation Cache**

Removing the installation cache in a Docker image is a good practice to reduce the overall size of the image.
Temporary files and caches are created during the installation process. These files are typically not needed after the installation is complete.

```Dockerfile
RUN rm -rf /var/cache/apk/*
```

**Default Command**

In a Dockerfile, the CMD instruction specifies the default command that should be executed when a container is run. 

```Dockerfile
CMD ["newman", "run", "/usr/local/bin/set_dns.sh"]
```

**Environment Variable**

the ENV instruction is used to set an environment variable named NODE_PATH

```Dockerfile
ENV NODE_PATH /usr/local/lib/node_modules
```

**Entry Point**

the ENTRYPOINT instruction specifies the command that will be run when a container is started from the image. 

```Dockerfile
ENTRYPOINT ["newman"]
```

### To build this image 

```Dockerfile
docker build -t .
```
