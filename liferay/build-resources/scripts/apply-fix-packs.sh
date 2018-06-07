#!/bin/bash -x

env

PATCHING_TOOL_DIR=${BUILD_RESOURCES_DIR}/patching-tool
PATCHING_TOOL_HOME=/opt/java/liferay/patching-tool

if [ -z "$PATCH_URLS" ]
then
    exit 0
fi

rm -rf ${PATCHING_TOOL_HOME}
cp -r ${PATCHING_TOOL_DIR} ${PATCHING_TOOL_HOME}

touch ${PATCHING_TOOL_HOME}/default.properties
echo "patching.mode=binary" >> ${PATCHING_TOOL_HOME}/default.properties
echo "war.path=../tomcat/webapps/ROOT/" >> ${PATCHING_TOOL_HOME}/default.properties
echo "global.lib.path=../src/portal/portal-service/" >> ${PATCHING_TOOL_HOME}/default.properties
echo "global.lib.path=../tomcat/lib/ext/" >> ${PATCHING_TOOL_HOME}/default.properties

bash ${PATCHING_TOOL_HOME}/patching-tool.sh install -force
rm -rfv ${PATCHING_TOOL_HOME}/patches/*
rm -rfv /opt/java/liferay/tomcat/webapps/ROOT/WEB-INF/patching-backup.zip