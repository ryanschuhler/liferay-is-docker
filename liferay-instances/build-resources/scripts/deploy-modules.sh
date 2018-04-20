#!/bin/bash -x

REPO_DIR=${BUILD_RESOURCES_DIR}/repo

[ -d ${REPO_DIR} ] || mkdir ${REPO_DIR}
cd ${REPO_DIR}

eval "$(ssh-agent -s)"
ssh-add ${BUILD_RESOURCES_DIR}/.ssh/id_rsa
ssh -o StrictHostKeyChecking=no -l $(whoami) github.com

#git clone ${GIT_REPO} --single-branch --branch ${GIT_BRANCH} --depth=1 --progress ${REPO_DIR}

#git reset --hard ${GIT_HASH}

echo Deployed!