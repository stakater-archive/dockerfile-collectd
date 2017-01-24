#!/bin/bash
_collectd_version=$1
_collectd_tag=$2
_release_build=false

if [ -z "${_collectd_version}" ]; then
	source COLLECTD_VERSION
	_collectd_version=$COLLECTD_VERSION
	_collectd_tag=$COLLECTD_VERSION
	_release_build=true
fi

echo "COLLECTD_VERSION: ${_collectd_version}"
echo "DOCKER TAG: ${_collectd_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --build-arg COLLECTD_VERSION=${_collectd_version} --tag "stakater/collectd:${_collectd_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker build --build-arg COLLECTD_VERSION=${_collectd_version} --tag "stakater/collectd:latest"  --no-cache=true .
fi
