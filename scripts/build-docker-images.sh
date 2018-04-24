#!/bin/bash
set -x

docker build \
	-t ryanschuhler/elasticsearch:ism \
	../elasticsearch

docker build \
	-t ryanschuhler/httpd:ism \
	../httpd

docker build \
	-t ryanschuhler/hubspot:ism \
	../hubspot

docker build \
	-t ryanschuhler/hubspot:ism \
	../hubspot

docker build \
	-t ryanschuhler/liferay:7.0 \
	--build-arg BUNDLE_URL=http://files.liferay.com/private/ee/portal/7.0.10/liferay-dxp-digital-enterprise-tomcat-7.0-ga1-20160617092557801.zip \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/7.0/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/7.0.10/de/liferay-fix-pack-de-44-7010.zip \
	../liferay

docker build \
	-t ryanschuhler/liferay:6.2 \
	--build-arg BASE_IMAGE=alpine:3.4 \
	--build-arg BUNDLE_URL=http://files.liferay.com/private/ee/portal/6.2.10.15/liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip \
	--build-arg JAVA_PACKAGE=openjdk7 \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/6.2/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/6.2.10/portal/liferay-fix-pack-portal-165-6210.zip \
	../liferay

docker build \
	-t ryanschuhler/liferay:6.1 \
	--build-arg BASE_IMAGE=alpine:3.4 \
	--build-arg BUNDLE_URL=https://files.liferay.com/private/ee/portal/6.1.30.5/liferay-portal-tomcat-6.1-ee-ga3-sp5-20160201142343123.zip \
	--build-arg JAVA_PACKAGE=openjdk7 \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/6.1/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/6.1.20/hotfix/liferay-hotfix-4323-6120.zip \
	../liferay

docker build \
	-t ryanschuhler/mariadb:ism \
	../mariadb

docker build \
	-t ryanschuhler/mockmock:ism \
	../mockmock

docker build \
	-t ryanschuhler/liferay:www-dxp \
	--build-arg BASE_IMAGE=ryanschuhler/liferay:7.0 \
	--build-arg CONFIG_RESOURCES_DIR=./configs/local \
	--build-arg DEPLOYMENT_ITEMS=modules/private/apps/osb-www/osb-www-theme \
	--build-arg GIT_BRANCH=7.0.x-private \
	--build-arg GIT_REPO=git@github.com:liferay/liferay-portal-ee.git \
	../liferay-instances

docker build \
	-t ryanschuhler/liferay:www-prod \
	--build-arg ADDITIONAL_PACKAGES=openjdk7 \
	--build-arg BASE_IMAGE=ryanschuhler/liferay:6.2 \
	--build-arg BUILD_SCRIPTS=deploy-plugins.sh \
	--build-arg CONFIG_RESOURCES_DIR=./configs/local \
	--build-arg DEPLOYMENT_ITEMS=hooks/osb-www-hook,hooks/portal-compat-hook,portlets/osb-www-asset-publisher-portlet,portlets/hubspot-portlet,themes/osb-community-theme,portlets/osb-www-marketing-events-portlet,portlets/marketplace-portlet,portlets/osb-www-portlet,webs/elasticsearch-web,themes/osb-www-events-theme \
	--build-arg GIT_BRANCH=ee-6.2.x \
	--build-arg GIT_REPO=git@github.com:liferay/liferay-plugins-ee.git \
	../liferay-instances

docker build \
	-t ryanschuhler/liferay:web-prod \
	--build-arg ADDITIONAL_PACKAGES=openjdk7 \
	--build-arg BASE_IMAGE=ryanschuhler/liferay:6.1 \
	--build-arg BUILD_SCRIPTS=deploy-plugins.sh \
	--build-arg CONFIG_RESOURCES_DIR=./configs/local \
	--build-arg DEPLOYMENT_ITEMS=ext/osb-ext,hooks/kaleo-upgrade-hook,hooks/osb-hook,hooks/portal-compat-hook,portlets/akismet-portlet,portlets/audit-portlet,portlets/ddl-form-portlet,portlets/ecommerce-portlet,portlets/google-search-appliance-portlet,portlets/hubspot-portlet,portlets/ip-geocoder-portlet,portlets/my-subscriptions-portlet,portlets/oauth-portlet,portlets/osb-corp-profile-portlet,portlets/osb-marketplace-order-portlet,portlets/osb-marketplace-order-portlet,portlets/osb-partnership-portlet,portlets/osb-portlet,portlets/osb-salesforce-gateway-portlet,portlets/osb-ui-portlet,portlets/rabbitmq-portlet,portlets/release-notes-portlet,portlets/saml-portlet,portlets/social-coding-portlet,portlets/social-networking-portlet,portlets/token-auth-portlet,portlets/web-form-portlet,themes/osb-community-theme,themes/osb-conference-theme,themes/osb-ray-by-day-theme,themes/osb-support-theme,themes/osb-symposium-2013-theme,themes/osb-symposium-2014-theme,themes/osb-universal-theme,themes/osb-welcome-theme,themes/osb-www-theme,webs/ehcache-cluster-web,webs/elasticsearch-web,webs/jira-web,webs/kaleo-web,webs/osb-blogs-web,webs/skinny-web,webs/vldap-web \
	--build-arg GIT_BRANCH=ee-6.1.x \
	--build-arg GIT_REPO=git@github.com:liferay/liferay-plugins-ee.git \
	../liferay-instances