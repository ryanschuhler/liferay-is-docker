#!/bin/bash -x

REPO_DIR=${BUILD_RESOURCES_DIR}/repo

[ -d ${REPO_DIR} ] || mkdir ${REPO_DIR}
cd ${REPO_DIR}

echo ${GIT_BRANCH} ${GIT_REPO}

git clone -b ${GIT_BRANCH} ${GIT_REPO}