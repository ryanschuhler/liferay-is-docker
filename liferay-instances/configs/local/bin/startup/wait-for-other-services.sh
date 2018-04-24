#!/bin/bash

chmod u+x ${LIFERAY_HOME}/bin/wait-for-it.sh
bash ${LIFERAY_HOME}/bin/wait-for-it.sh -t 600 ${DB_CONTAINER}:3306
bash ${LIFERAY_HOME}/bin/wait-for-it.sh -t 600 ${SEARCH_CONTAINER}:9200
