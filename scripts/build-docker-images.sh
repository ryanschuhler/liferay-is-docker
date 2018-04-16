#!/bin/bash

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
	--build-arg JAVA_PACKAGE=openjdk8 \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/7.0/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/7.0.10/de/liferay-fix-pack-de-44-7010.zip \
	../liferay-base

docker build \
	-t ryanschuhler/liferay:6.2 \
	--build-arg BUNDLE_URL=http://files.liferay.com/private/ee/portal/6.2.10.15/liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip \
	--build-arg JAVA_PACKAGE=openjdk7 \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/6.2/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/6.2.10/portal/liferay-fix-pack-portal-165-6210.zip \
	../liferay-base

docker build \
	-t ryanschuhler/liferay:6.1 \
	--build-arg BUNDLE_URL=https://files.liferay.com/private/ee/portal/6.1.30.5/liferay-portal-tomcat-6.1-ee-ga3-sp5-20160201142343123.zip \
	--build-arg JAVA_PACKAGE=openjdk7 \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/6.1/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/6.1.20/hotfix/liferay-hotfix-4323-6120.zip \
	../liferay-base

docker build \
	-t ryanschuhler/mariadb:ism \
	../mariadb

docker build \
	-t ryanschuhler/mockmock:ism \
	../mockmock