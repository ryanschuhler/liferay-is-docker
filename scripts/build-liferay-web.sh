#!/bin/bash

docker build \
	-t ryanschuhler/liferay:web-prod \
	--build-arg BASE_IMAGE=ryanschuhler/liferay:6.1 \
	--build-arg BUILD_SCRIPTS=deploy-plugins.sh \
	--build-arg CONFIG_RESOURCES_DIR=./configs/web-prod \
	--build-arg DEPLOYMENT_ITEMS=ext/osb-ext,hooks/kaleo-upgrade-hook,hooks/osb-hook,hooks/portal-compat-hook,portlets/akismet-portlet,portlets/audit-portlet,portlets/ddl-form-portlet,portlets/ecommerce-portlet,portlets/google-search-appliance-portlet,portlets/hubspot-portlet,portlets/ip-geocoder-portlet,portlets/my-subscriptions-portlet,portlets/oauth-portlet,portlets/osb-corp-profile-portlet,portlets/osb-marketplace-order-portlet,portlets/osb-marketplace-order-portlet,portlets/osb-partnership-portlet,portlets/osb-portlet,portlets/osb-salesforce-gateway-portlet,portlets/osb-ui-portlet,portlets/rabbitmq-portlet,portlets/release-notes-portlet,portlets/saml-portlet,portlets/social-coding-portlet,portlets/social-networking-portlet,portlets/token-auth-portlet,portlets/web-form-portlet,themes/osb-community-theme,themes/osb-conference-theme,themes/osb-ray-by-day-theme,themes/osb-support-theme,themes/osb-symposium-2013-theme,themes/osb-symposium-2014-theme,themes/osb-universal-theme,themes/osb-welcome-theme,themes/osb-www-theme,webs/ehcache-cluster-web,webs/elasticsearch-web,webs/jira-web,webs/kaleo-web,webs/osb-blogs-web,webs/skinny-web,webs/vldap-web \
	--build-arg GIT_BRANCH=ee-6.1.x \
	--build-arg GIT_REPO=git@github.com:liferay/liferay-plugins-ee.git \
	../liferay-instances