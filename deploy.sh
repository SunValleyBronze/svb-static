#!/bin/bash

# This script will quit on the first error that is encountered.
set -e

DEPLOY_DATE=`date "+%Y%m%d%H%M"`

aws s3 cp pdfjs-1.5.188-customized s3://sunvalleybronze-viewer.com/deploy$DEPLOY_DATE --recursive --acl public-read
