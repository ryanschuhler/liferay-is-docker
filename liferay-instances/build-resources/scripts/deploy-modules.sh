#!/bin/bash -x

REPO_DIR=${BUILD_RESOURCES_DIR}/repo

[ -d ${REPO_DIR} ] || mkdir ${REPO_DIR}
cd ${REPO_DIR}

ssh-add -K ${BUILD_RESOURCES}/.ssh/id_rsa

git clone -b ${GIT_BRANCH} ${GIT_REPO}
