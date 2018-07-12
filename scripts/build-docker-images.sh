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
	-t ryanschuhler/mariadb:ism \
	../mariadb

docker build \
	-t ryanschuhler/mockmock:ism \
	../mockmock

./build-liferay-base.sh

./build-liferay-web.sh

./build-liferay-www.sh

./build-liferay-dxp.sh