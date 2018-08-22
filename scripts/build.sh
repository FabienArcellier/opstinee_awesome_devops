#!/usr/bin/env bash

readonly SCRIPT_DIR=$( cd "$(dirname "${0}" )" && pwd );
readonly ROOT_DIR="${SCRIPT_DIR}/.."

function main
{
    check_environment_variable AWS_ACCESS_KEY_ID "set the environment variable AWS_ACCESS_KEY_ID ..."
    check_environment_variable AWS_SECRET_ACCESS_KEY "set the environment variable AWS_SECRET_ACCESS_KEY ..."
    check_environment_variable AWS_DEFAULT_REGION "set the environment variable AWS_DEFAULT_REGION ..."
    check_environment_variable S3_ARTEFACT_REPOSITORY_URL "set the environment variable S3_ARTEFACT_REPOSITORY_URL ..."

    check_command_exists sphinx-build "sphinx-build is missing, setup sphinx"
    check_command_exists aws ""

    set -o errexit -o nounset

    cd "${ROOT_DIR}"
    make html
    git log -n1 --format="$(cat VERSION.in)+git%h" > build/html/VERSION
    cd "${ROOT_DIR}/build/html"
    tar -cvf ../../awesome_devops.tar.gz ./*
    cd "${ROOT_DIR}"
    aws s3 cp "${ROOT_DIR}/awesome_devops.tar.gz" "${S3_ARTEFACT_REPOSITORY_URL}/awesome_devops.tar.gz"
}

function check_environment_variable
{
  var=${!1}
  message=$2
  [ -z "${var}" ] && (>&2 echo ${message}) && exit 1;
}

function check_command_exists
{
  command=$1
  message=$2
  command -v ${command} >/dev/null 2>&1 || {  (>&2 echo ${message}); exit 1; }
}


main "$@"



