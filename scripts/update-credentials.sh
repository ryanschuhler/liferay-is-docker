#!/bin/bash

BUILD_RESOURCES=../liferay-base/build-resources

echo Enter your username for mirrors.liferay
read username
echo $username > ${BUILD_RESOURCES}/.username

echo Enter your password for mirrors.liferay
read -s password
echo $password > ${BUILD_RESOURCES}/.password

echo Thanks, your username and password have been stored locally.
