#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    create role frost with login password 'frost';
    create database sensorthings with owner frost;
    \c sensorthings;
    create extension if not exists postgis;
EOSQL
