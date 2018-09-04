ARG BASE_IMAGE=alpine:latest

FROM ${BASE_IMAGE} AS liferay-build

ARG BUILD_RESOURCES_DIR=/tmp/build-resources
ARG BUILD_SCRIPTS=bundle-exclude.sh,apply-fix-packs.sh
ARG BUNDLE_URL
ARG CREDENTIALS
ARG LICENSE_URL
ARG LIFERAY_BUNDLE_NAME=bundle.zip
ARG PATCH_URLS
ARG PATCHING_TOOL_URL=http://files.liferay.com/private/ee/fix-packs/patching-tool/patching-tool-22.zip

ENV LIFERAY_HOME=/opt/java/liferay
ENV PATH=${PATH}:${LIFERAY_HOME}/bin:${LIFERAY_HOME}/tomcat/bin/

RUN apk update \
	&& apk upgrade \
	&& apk add bash curl unzip openjdk8 \
	&& addgroup -S liferay \
	&& adduser -S -G liferay liferay

COPY ./build-resources/ ${BUILD_RESOURCES_DIR}/

RUN ${BUILD_RESOURCES_DIR}/scripts/get-dependencies.sh

RUN if [ -f "${BUILD_RESOURCES_DIR}/${LIFERAY_BUNDLE_NAME}" ] \
  ; then \
    set -x \
    && mkdir -p /opt/java \
    && unzip ${BUILD_RESOURCES_DIR}/${LIFERAY_BUNDLE_NAME} -d /opt/java \
    && find /opt/java -depth -maxdepth 1 -type d -name "liferay-*" -exec mv {} ${LIFERAY_HOME} \; \
    && mkdir -p ${LIFERAY_HOME}/deploy \
    && find ${LIFERAY_HOME} -depth -maxdepth 1 -type d -name "tomcat-*" -exec mv {} ${LIFERAY_HOME}/tomcat \; \
    && mkdir -p ${LIFERAY_HOME}/bin \
    && mv ${BUILD_RESOURCES_DIR}/startup ${LIFERAY_HOME}/bin \
    && chmod +x ${LIFERAY_HOME}/bin/startup/*.sh \
  ; fi

RUN chmod +x ${BUILD_RESOURCES_DIR}/scripts/*.sh \
  && for script in $(echo ${BUILD_SCRIPTS} | sed "s/,/ /g") \
    ; do \
       if [ -f ${BUILD_RESOURCES_DIR}/scripts/${script} ] \
       ; then \
         echo "Running ${script}"; \
         bash -x "${BUILD_RESOURCES_DIR}/scripts/${script}" \
       ; fi \
    ; done

COPY ./build-resources/scripts/entrypoint.sh ${LIFERAY_HOME}/bin/entrypoint.sh

EXPOSE 8080
EXPOSE 11311

ENTRYPOINT ["entrypoint.sh"]
CMD ["catalina.sh", "run"]