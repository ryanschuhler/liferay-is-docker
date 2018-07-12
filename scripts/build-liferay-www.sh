#!/bin/bash

docker build \
	-t ryanschuhler/liferay:www-prod \
	--build-arg BASE_IMAGE=ryanschuhler/liferay:6.2 \
	--build-arg BUILD_SCRIPTS=deploy-plugins.sh \
	--build-arg CONFIG_RESOURCES_DIR=./configs/www-prod \
	--build-arg DEPLOYMENT_ITEMS=hooks/osb-www-hook,hooks/portal-compat-hook,portlets/osb-www-asset-publisher-portlet,portlets/hubspot-portlet,themes/osb-community-theme,portlets/osb-www-marketing-events-portlet,portlets/marketplace-portlet,portlets/osb-www-portlet,webs/elasticsearch-web,themes/osb-www-events-theme \
	--build-arg GIT_BRANCH=ee-6.2.x \
	--build-arg GIT_REPO=git@github.com:liferay/liferay-plugins-ee.git \
	../liferay-instances