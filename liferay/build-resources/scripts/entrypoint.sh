#!/bin/bash -x

for script in ${LIFERAY_HOME}/bin/startup/*.sh; do
    if [ -f "${LIFERAY_HOME}/bin/startup/${script}" ]; then
        bash -x "${LIFERAY_HOME}/bin/startup/${script}"
    fi
done

exec "$@"