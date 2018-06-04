ARG BASE_IMAGE

FROM ${BASE_IMAGE} AS liferay-build

ARG ADDITIONAL_PACKAGES=openjdk8
ARG BUILD_RESOURCES_DIR=/tmp/build-resources
ARG BUILD_SCRIPTS=deploy-modules.sh
ARG CONFIG_RESOURCES_DIR=./configs/www-dxp
ARG DEPLOYMENT_ITEMS
ARG GIT_BRANCH
ARG GIT_HASH=HEAD
ARG GIT_REPO

ENV LIFERAY_HOME=/opt/java/liferay

RUN apk update \
  && apk upgrade \
  && apk add apache-ant bash curl git openssh-client ${ADDITIONAL_PACKAGES}

COPY ./build-resources/ ${BUILD_RESOURCES_DIR}/

RUN chmod +x ${BUILD_RESOURCES_DIR}/scripts/*.sh \
  && set -x \
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

ARG ADDITIONAL_PACKAGES=openjdk8

ENV LIFERAY_HOME=/opt/java/liferay
ENV PATH=${PATH}:${LIFERAY_HOME}/bin:${LIFERAY_HOME}/tomcat/bin/

RUN apk update \
  && apk upgrade \
  && apk add --no-cache bash ${ADDITIONAL_PACKAGES} \
  && addgroup -S liferay \
  && adduser -S -G liferay liferay

USER liferay:liferay

COPY --chown=liferay:liferay --from=liferay-build /opt /opt

EXPOSE 8080
EXPOSE 11311

ENTRYPOINT ["entrypoint.sh"]
CMD ["catalina.sh", "run"]