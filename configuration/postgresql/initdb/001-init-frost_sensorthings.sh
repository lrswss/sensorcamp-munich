#!/bin/bash
set -e

if [ -z "$POSTGRES_USER" ]; then
	echo "ERROR: POSTGRES_USER not set!"
	exit 1
fi

if ! psql -ltq | cut -d '|' -f 2 | grep -qw frost; then
	echo "create role frost with login password 'frost';" | \
		psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER"
fi

if ! psql -ltq | cut -d '|' -f 1 | grep -qw sensorthings; then
	echo "create database sensorthings with owner frost;" | \
		psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER"
fi
