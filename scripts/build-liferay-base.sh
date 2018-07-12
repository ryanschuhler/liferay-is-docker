#!/bin/bash

docker build \
	-t ryanschuhler/liferay:7.1 \
	--build-arg BUNDLE_URL=http://files.liferay.com/private/ee/portal/7.1.10/liferay-dxp-tomcat-7.1.10-ga1-20180703090613030.zip \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/7.0/license.xml \
	../liferay

docker build \
	-t ryanschuhler/liferay:6.2 \
	--build-arg BASE_IMAGE=alpine:3.4 \
	--build-arg BUNDLE_URL=http://files.liferay.com/private/ee/portal/6.2.10.21/liferay-portal-tomcat-6.2-ee-sp20-20170717160924965.zip \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/6.2/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/6.2.10/hotfix/liferay-hotfix-26906-6210.zip \
	../liferay

docker build \
	-t ryanschuhler/liferay:6.1 \
	--build-arg BASE_IMAGE=alpine:3.4 \
	--build-arg BUNDLE_URL=https://files.liferay.com/private/ee/portal/6.1.20/liferay-portal-tomcat-6.1.20-ee-ga2-20120731110418084.zip \
	--build-arg LICENSE_URL=http://files.liferay.com/private/ee/liferay-up/License/6.1/license.xml \
	--build-arg PATCH_URLS=http://files.liferay.com/private/ee/fix-packs/6.1.20/hotfix/liferay-hotfix-4323-6120.zip \
	../liferay