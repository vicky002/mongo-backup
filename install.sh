set -e

apt-get update && apt-get -y install cron python python-pip

pip install awscli

mkdir -p /opt/backup/

cp backup.sh /opt/backup/backup.sh
chmod +x /opt/backup/backup.sh

cp backup.cron /opt/backup/backup.cron
chmod 0644 /opt/backup/backup.cron
crontab /opt/backup/backup.cron

# Written by Vikesh Tiwari [https://www.github.com/vicky002]
