make html
cd build/html
tar -cvf ../../awesome_devops.tar.gz *
cd ../..
aws s3 cp awesome_devops.tar.gz ${S3_ARTEFACT_REPOSITORY_URL}/awesome_devops.tar.gz
