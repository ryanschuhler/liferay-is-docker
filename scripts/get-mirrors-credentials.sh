#!/bin/bash

CREDENTIALS=
PASSWORD=
REPO_ROOT=$(git rev-parse --show-toplevel)
USERNAME=

if [[ ! -z "${MIRRORS_USERNAME}" ]]; then
    USERNAME="${MIRRORS_USERNAME}"
fi

if [[ ! -z "${MIRRORS_PASSWORD}" ]]; then
    PASSWORD="${MIRRORS_PASSWORD}"
fi

if [ -z "${USERNAME}" ] && [ -f "${REPO_ROOT}/scripts/.username" ]; then
    USERNAME="$(cat ${REPO_ROOT}/scripts/.username)"
fi

if [ -z "${PASSWORD}" ] && [ -f "${REPO_ROOT}/scripts/.password" ]; then
    PASSWORD="$(cat ${REPO_ROOT}/scripts/.password)"
fi

if [ ! -z "${USERNAME}" ] && [ ! -z "${PASSWORD}" ]; then
	CREDENTIALS="-u ${USERNAME}:${PASSWORD}"
fi

echo ${CREDENTIALS}