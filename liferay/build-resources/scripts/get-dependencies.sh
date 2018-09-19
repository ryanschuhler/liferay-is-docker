#!/bin/bash

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
  downloadFile ${LICENSE_URL} ${BUILD_RESOURCES_DIR}/startup/license.xml
fi

if [ ${PATCH_URLS} != "" ]; then
  PATCHING_TOOL_DIR=${BUILD_RESOURCES_DIR}/patching-tool

  downloadFile ${PATCHING_TOOL_URL} ${BUILD_RESOURCES_DIR}/patching-tool.zip
  unzip ${BUILD_RESOURCES_DIR}/patching-tool.zip -d ${BUILD_RESOURCES_DIR}

  PATCHES_DIR=${PATCHING_TOOL_DIR}/patches

  [ -d "${PATCHES_DIR}" ] || mkdir "${PATCHES_DIR}"
  for PATCH in $(echo ${PATCH_URLS} | sed "s/,/ /g")
  do
      downloadFile ${PATCH} ${PATCHES_DIR}/${PATCH##*/}
  done
fi
