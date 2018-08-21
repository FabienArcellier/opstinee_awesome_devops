make html
git log -n1 --format="$(cat VERSION.in)+git%h" > build/html/VERSION
cd build/html
tar -cvf ../../awesome_devops.tar.gz *
cd ../..

aws s3 cp awesome_devops.tar.gz ${S3_ARTEFACT_REPOSITORY_URL}/awesome_devops.tar.gz
