#!/bin/bash

DATABASE_URL=http://mirrors/files.liferay.com/private/lrdcom/www_lportal-2018-04-10_19-00-PDT.sql.gz

DATABASE_DEST_FOLDER=../docker-entrypoint-initdb.d

DATABASE_DEST_FILE=${DATABASE_DEST_FOLDER}/${DATABASE_URL##*/}

FORCE=false

while getopts f opt; do
  case ${opt} in
    f)
      FORCE=true;;
    [?])
      echo "Usage: add option [-f] to force update the database";;
  esac
done

if [ ${FORCE} == true ]; then
  rm ${DATABASE_DEST_FOLDER}/*.sql.gz
fi

if [ ! -f ${DATABASE_DEST_FILE} ]; then
  echo "Downloading ${DATABASE_URL} to ${DATABASE_DEST}/${DATABASE_URL##*/}"
  curl -o "${DATABASE_DEST_FILE}" -fSL ${DATABASE_URL}
else
  echo "Skipping download because ${DATABASE_DEST_FILE} already exists."
fi
