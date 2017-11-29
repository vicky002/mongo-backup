# OBS: NOT USED AT THE MOMENT!

FROM ubuntu:xenial
LABEL maintainer="hi@eulercoder.me"

# Install dependencies
RUN apt-get update && apt-get -y install cron python python-pip

# Install AWS CLI
RUN pip install awscli

# Install MongoDB tools
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update && apt-get install -y mongodb-org-tools

# Add backup script
ADD backup.sh /opt/backup.sh
RUN chmod +x /opt/backup.sh

# Add crontab file in the cron directory
ADD backup.cron /opt/backup.cron
RUN chmod 0644 /opt/backup.cron
RUN crontab /opt/backup.cron

# Run the command on container startup
CMD touch /var/log/cron.log && cron && tail -f /var/log/cron.log

# Written by Vikesh Tiwari [https://www.github.com/vicky002]
