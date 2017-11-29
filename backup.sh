#!/bin/bash
set -e

export MONGODB_URI=''
export AWS_ACCESS_KEY = ''
export AWS_SECRET_ACCESS_KEY=

NAME=$1
DUMP=dump_$NAME
echo "Running backup $1 ..."

# Do backup
# echo "Dumping database ..."
# mongodump -v --uri "$MONGODB_URI" -o $DUMP && tar -zcvf $DUMP.tar.gz $DUMP
# echo "test" > $DUMP.tar.gz



# Do backup
echo "Dumping database ..."
mongodump -v --authenticationDatabase admin -u 'ADMIN_USERNAME' --password 'PASSWORD' -o $DUMP


# Archive (without compression, due to CPU usage...)
echo "Archiving dump ..."
tar -cvf $DUMP.tar.gz $DUMP


# Run upload
/usr/local/bin/aws s3 cp $DUMP.tar.gz 'YOUR_S3_URL_HERE' --storage-class STANDARD_IA # maybe? Enter your class

echo "Cleaning temp files"
rm -rf $DUMP_*

echo "Done"

# Written by Vikesh Tiwari [https://www.github.com/vicky002]