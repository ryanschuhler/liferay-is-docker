#!/bin/bash

SSH_KEY_DIR=../liferay-instances/build-resources/.ssh

mkdir -p ${SSH_KEY_DIR}

ssh-keygen -t rsa -b 4096 -C "$(git config --global user.email)" -f ${SSH_KEY_DIR}/id_rsa -N ''

curl -u "$(git config --global user.name)" \
  --data "{\"title\":\"`date +%m/%d/%Y-%H:%M:%S`_DOCKER-LIFERAY\",\"key\":\"`cat ${SSH_KEY_DIR}/id_rsa.pub`\"}" \
  https://api.github.com/user/keys