#!/bin/bash -x

REPO_DIR=${BUILD_RESOURCES_DIR}/repo

[ -d ${REPO_DIR} ] || mkdir ${REPO_DIR}
cd ${REPO_DIR}

eval "$(ssh-agent -s)"
ssh-add ${BUILD_RESOURCES_DIR}/.ssh/id_rsa
ssh -o StrictHostKeyChecking=no -l $(whoami) github.com

git clone ${GIT_REPO} --single-branch --branch ${GIT_BRANCH} --depth=1 --progress ${REPO_DIR}

git reset --hard ${GIT_HASH}

BUILD_PROPERTIES_FILE=${REPO_DIR}/build.$(whoami).properties

touch ${BUILD_PROPERTIES_FILE}

echo "app.server.parent.dir=${LIFERAY_HOME}" >> ${BUILD_PROPERTIES_FILE}
echo "app.server.tomcat.dir=\${app.server.parent.dir}/tomcat" >> ${BUILD_PROPERTIES_FILE}

export JAVA_HOME /usr/lib/jvm/java-1.7-openjdk
cp /opt/java/liferay/tomcat/lib/ecj* /usr/share/java/apache-ant/lib

for item in $(echo ${DEPLOYMENT_ITEMS} | sed "s/,/ /g")
do
	if [ -d ${REPO_DIR}/${item} ] ; then
		echo "Deploying ${item}";

		cd ${REPO_DIR}/${item}

		ant deploy
	fi
done