ARG BASE_IMAGE
ARG BUILD_RESOURCES_DIR=/tmp/build-resources
ARG CONFIG_RESOURCES_DIR
ARG BUILD_SCRIPTS=deploy-modules.sh
ARG GIT_BRANCH
ARG GIT_HASH
ARG GIT_REPO
ARG JAVA_PACKAGE

FROM BASE_IMAGE AS liferay-build

ENV LIFERAY_HOME=/opt/java/liferay

RUN apk update \
  && apk upgrade \
  && apk add bash curl git $JAVA_PACKAGE openssh-client unzip zip

COPY ./build-resources/ ${BUILD_RESOURCES_DIR}/

RUN chmod +x ${BUILD_RESOURCES_DIR}/scripts/*.sh \
  && for script in $(echo ${BUILD_SCRIPTS} | sed "s/,/ /g") \
    ; do \
       if [ -f ${BUILD_RESOURCES_DIR}/scripts/${script} ] \
       ; then \
         echo "Running ${script}"; \
         bash -x "${BUILD_RESOURCES_DIR}/scripts/${script}" \
       ; fi \
    ; done

COPY ${CONFIG_RESOURCES_DIR}/ ${LIFERAY_HOME}/

FROM alpine:latest

ARG JAVA_PACKAGE

ENV LIFERAY_HOME=/opt/java/liferay

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