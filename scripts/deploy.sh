mkdir -p dist
aws s3 cp ${S3_ARTEFACT_REPOSITORY_URL}/awesome_devops.tar.gz dist/
cd dist
tar -xvf awesome_devops.tar.gz
cd ..
rm dist/awesome_devops.tar.gz
aws s3 sync dist ${S3_WEBSITE_URL}
