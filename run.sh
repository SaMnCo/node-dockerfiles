#!/bin/bash
# If the New Relic config file exists, will suppose


NR_CONFIG="/etc/kube-newrelic/config"

[ -f "${NR_CONFIG}" ] && {
	NR_API_KEY=$(cat "${NR_CONFIG}" | grep "NRSYSMOND_license_key" | cut -f2 -d"=")
	APP_NAME=$(cat package.json | grep "name" | cut -f4 -d'"')

	find . -name "newrelic.js" -exec \
		sed -e s/My\ Application/${APP_NAME}/g \
			-e s/license\ key\ here/${NR_API_KEY}/g \
			-e s/info/trace/ \
			{} \;

	[ $(egrep "newrelic" index.js) ] || sed -i "1ivar newrelic = require('newrelic');" index.js
}

npm start 



