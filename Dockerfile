FROM alpine:latest AS liferay-build

ARG BUILD_RESOURCES_DIR=/tmp/build-resources
ARG BUILD_SCRIPTS=bundle-exclude.sh,apply-fix-packs.sh
ARG BUNDLE_URL=http://files.liferay.com/private/ee/portal/7.0.10/liferay-dxp-digital-enterprise-tomcat-7.0-ga1-20160617092557801.zip
ARG JAVA_PACKAGE=openjdk8
ARG LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/7.0/license.xml
ARG LIFERAY_BUNDLE_NAME=bundle.zip
ARG PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/7.0.10/de/liferay-fix-pack-de-44-7010.zip

ENV LIFERAY_HOME=/opt/java/liferay

RUN apk update \
  && apk upgrade \
  && apk add bash curl git $JAVA_PACKAGE openssh-client unzip zip

COPY ./build-resources/ ${BUILD_RESOURCES_DIR}/

RUN ${BUILD_RESOURCES_DIR}/scripts/get-dependencies.sh

RUN if [ -f "${BUILD_RESOURCES_DIR}/${LIFERAY_BUNDLE_NAME}" ] \
  ; then \
    set -x \
    && mkdir -p /opt/java \
    && unzip ${BUILD_RESOURCES_DIR}/${LIFERAY_BUNDLE_NAME} -d /opt/java \
    && find /opt/java -depth -maxdepth 1 -type d -name "liferay-*" -exec mv {} /opt/java/liferay \; \
    && mkdir -p /opt/java/liferay/deploy \
    && find /opt/java/liferay -depth -maxdepth 1 -type d -name "tomcat-*" -exec mv {} /opt/java/liferay/tomcat \; \
    && mkdir -p ${LIFERAY_HOME}/bin/startup \
    && cp ${BUILD_RESOURCES_DIR}/license.xml ${LIFERAY_HOME}/bin/startup/license.xml \
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

COPY ./resources/ ${LIFERAY_HOME}/

FROM alpine:latest

ARG JAVA_PACKAGE=openjdk8

ENV LIFERAY_DEFAULT_PERIOD_ADMIN_PERIOD_PASSWORD=test
ENV LIFERAY_HOME=/opt/java/liferay
ENV LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_DRIVER_UPPERCASEC_lass_UPPERCASEN_ame=org.mariadb.jdbc.Driver
ENV LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_PASSWORD=passw0rd
ENV LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_URL=jdbc:mariadb://mariadb/lportal?useUnicode=true&characterEncoding=UTF-8&useFastDateParsing=false
ENV LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_USERNAME=liferay
ENV VIRTUAL_PORT=8080

RUN apk update \
  && apk upgrade \
  && apk add --no-cache bash $JAVA_PACKAGE \
  && addgroup -S liferay \
  && adduser -S -G liferay liferay

USER liferay:liferay

COPY --chown=liferay:liferay --from=liferay-build $LIFERAY_HOME $LIFERAY_HOME

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 8080
EXPOSE 11311

ENTRYPOINT ["entrypoint.sh"]
CMD ["/opt/java/liferay/tomcat/bin/catalina.sh", "run"]
