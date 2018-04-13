#!/bin/bash

SSH_KEY_DIR=../liferay-base/build-resources/.ssh

echo Enter your Github email
read GITHUB_EMAIL

echo Enter your Github user name
read GITHUB_USER_NAME

mkdir -p ${SSH_KEY_DIR}
ssh-keygen -t rsa -b 4096 -C "${GITHUB_EMAIL}" -f ${SSH_KEY_DIR}/id_rsa -N ''

curl -u "${GITHUB_USER_NAME}" \
  --data "{\"title\":\"`date +%m/%d/%Y-%H:%M:%S`_DOCKER-LIFERAY\",\"key\":\"`cat ${SSH_KEY_DIR}/id_rsa.pub`\"}" \
  https://api.github.com/user/keys
