FROM docker:latest

RUN apk update \
	&& apk upgrade \
	&& apk add bash git

ARG MIRRORS_USERNAME
ARG MIRRORS_PASSWORD
ARG SSH_PRIVATE_KEY

ENV DOCKER_IMAGE_BUILDER_DIR=/opt/dockerimagebuilder
ENV SCRIPTS=./scripts/build-docker-images.sh
ENV SSH_PRIVATE_KEY=$SSH_PRIVATE_KEY

COPY ./ ${DOCKER_IMAGE_BUILDER_DIR}/

EXPOSE 8080

RUN chmod a+x ${DOCKER_IMAGE_BUILDER_DIR}/entrypoint.sh

ENTRYPOINT ["${DOCKER_IMAGE_BUILDER_DIR}/entrypoint.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
