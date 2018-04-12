#!/bin/bash

CREDENTIALS=""

if [ -f "${BUILD_RESOURCES_DIR}/.username" ] && [ -f "${BUILD_RESOURCES_DIR}/.password" ]; then
    CREDENTIALS="-u $(cat ${BUILD_RESOURCES_DIR}/.username):$(cat ${BUILD_RESOURCES_DIR}/.password)"
fi

downloadFile() {
    URL=$1
    DEST=$2

    if [ ! -f ${DEST} ]; then
        echo "Downloading ${URL} to ${DEST}"

        curl ${CREDENTIALS} -o ${DEST} -fSL ${URL}
    else
        echo "Skipping download because ${DEST} already exists."
    fi
}

downloadFile ${BUNDLE_URL} ${BUILD_RESOURCES_DIR}/bundle.zip

if [ ${LICENSE_URL} != "" ]; then
  downloadFile ${LICENSE_URL} ${BUILD_RESOURCES_DIR}/license.xml
fi

if [ ${PATCH_URLS} != "" ]; then
  PATCHES_DIR=${BUILD_RESOURCES_DIR}/patches
  [ -d "${PATCHES_DIR}" ] || mkdir "${PATCHES_DIR}"
  for PATCH in $(echo ${PATCH_URLS} | sed "s/,/ /g")
  do
      downloadFile ${PATCH} ${PATCHES_DIR}/${PATCH##*/}
  done
fi
