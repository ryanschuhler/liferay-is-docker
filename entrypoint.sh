#!/bin/bash

SCRIPTS_DIR=${DOCKER_IMAGE_BUILDER_DIR}/scripts

${SCRIPTS_DIR}/create-ssh-key.sh

for script in $(echo ${SCRIPTS} | sed "s/,/ /g")
do
   if [ -f ${SCRIPTS_DIR}/${script} ]
   then
     echo "Running ${script}";
     ${SCRIPTS_DIR}/${script}
   fi
done

${SCRIPTS_DIR}/push-docker-images.sh
