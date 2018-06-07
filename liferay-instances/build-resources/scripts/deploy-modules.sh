#!/bin/bash -x

REPO_DIR=${BUILD_RESOURCES_DIR}/repo

apk add git

[ -d ${REPO_DIR} ] || mkdir ${REPO_DIR}
cd ${REPO_DIR}

eval "$(ssh-agent -s)"
ssh-add ${BUILD_RESOURCES_DIR}/.ssh/id_rsa
ssh -o StrictHostKeyChecking=no -l $(whoami) github.com

git clone ${GIT_REPO} --single-branch --branch ${GIT_BRANCH} --depth=1 --progress ${REPO_DIR}

git reset --hard ${GIT_HASH}

for item in $(echo ${DEPLOYMENT_ITEMS} | sed "s/,/ /g")
do
	if [ -d ${REPO_DIR}/${item} ] ; then
		echo "Deploying ${item}";

		cd ${REPO_DIR}/${item}

		$(git rev-parse --show-toplevel)/gradlew deploy
	fi
done