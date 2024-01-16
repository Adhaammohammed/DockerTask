# Use the base image
FROM postman/newman:6.0.0-alpine

# Update and install necessary packages using a single RUN command to reduce layering

RUN apk update
RUN apk upgrade
RUN apk add --no-cache curl zip iputils nodejs npm
RUN npm install -g newman-reporter-csvallinone

# Set DNS servers explicitly in Alpine
COPY set_dns.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/set_dns.sh
# Remove installation cache
RUN rm -rf /var/cache/apk/*
CMD ["newman", "run", "/usr/local/bin/set_dns.sh"]
# Set environment variable NODE_PATH
ENV NODE_PATH /usr/local/lib/node_modules

# Set working directory
WORKDIR /etc/newman
# Set entry point to newman  
ENTRYPOINT ["newman"]
# execute the script when container starts