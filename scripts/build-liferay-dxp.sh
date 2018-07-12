#!/bin/bash

docker build \
	-t ryanschuhler/liferay:www-dxp \
	--build-arg BASE_IMAGE=ryanschuhler/liferay:7.1 \
	--build-arg CONFIG_RESOURCES_DIR=./configs/www-dxp \
	--build-arg DEPLOYMENT_ITEMS=modules/private/apps/osb-www/osb-www-theme \
	--build-arg GIT_BRANCH=7.0.x-private \
	--build-arg GIT_REPO=git@github.com:liferay/liferay-portal-ee.git \
	../liferay-instances