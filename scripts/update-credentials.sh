#!/bin/bash

SCRIPTS_DIR=../scripts

echo Enter your username for mirrors.liferay
read username
echo $username > ${SCRIPTS_DIR}/.username

echo Enter your password for mirrors.liferay
read -s password
echo $password > ${SCRIPTS_DIR}/.password

echo Thanks, your username and password have been stored locally.
