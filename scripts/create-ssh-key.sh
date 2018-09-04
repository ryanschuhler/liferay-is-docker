#!/bin/bash

SSH_KEY_DIR=../liferay-instances/build-resources/.ssh

mkdir -p ${SSH_KEY_DIR}

if [[ ! -z "${SSH_PRIVATE_KEY}" ]]; then
    echo "${SSH_PRIVATE_KEY}" > ${SSH_KEY_DIR}/id_rsa
    chmod 700 ${SSH_KEY_DIR}/id_rsa
    echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ${SSH_KEY_DIR}/config
elif [ ! -z "$(git config --global user.email)" ]; then
    ssh-keygen -t rsa -b 4096 -C "$(git config --global user.email)" -f ${SSH_KEY_DIR}/id_rsa -N ''

    curl -u "$(git config --global user.name)" \
      --data "{\"title\":\"`date +%m/%d/%Y-%H:%M:%S`_DOCKER-LIFERAY\",\"key\":\"`cat ${SSH_KEY_DIR}/id_rsa.pub`\"}" \
      https://api.github.com/user/keys
fi