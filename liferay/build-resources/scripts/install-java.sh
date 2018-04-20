#!/bin/bash -x

[ -d ${JDK_DIR} ] || mkdir -p ${JDK_DIR}

cd /tmp

curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_URL} | tar -xzf - -C ${JDK_DIR}

rm -rf ${JDK_DIR}/*src.zip \
	${JDK_DIR}/lib/missioncontrol \
	${JDK_DIR}/lib/visualvm \
	${JDK_DIR}/lib/*javafx* \
	${JDK_DIR}/jre/lib/plugin.jar \
	${JDK_DIR}/jre/lib/ext/jfxrt.jar \
	${JDK_DIR}/jre/bin/javaws \
	${JDK_DIR}/jre/lib/javaws.jar \
	${JDK_DIR}/jre/lib/desktop \
	${JDK_DIR}/jre/plugin \
	${JDK_DIR}/jre/lib/deploy* \
	${JDK_DIR}/jre/lib/*javafx* \
	${JDK_DIR}/jre/lib/*jfx* \
	${JDK_DIR}/jre/lib/amd64/libdecora_sse.so \
	${JDK_DIR}/jre/lib/amd64/libprism_*.so \
	${JDK_DIR}/jre/lib/amd64/libfxplugins.so \
	${JDK_DIR}/jre/lib/amd64/libglass.so \
	${JDK_DIR}/jre/lib/amd64/libgstreamer-lite.so \
	${JDK_DIR}/jre/lib/amd64/libjavafx*.so \
	${JDK_DIR}/jre/lib/amd64/libjfx*.so