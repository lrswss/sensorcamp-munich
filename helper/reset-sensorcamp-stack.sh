#!/bin/sh
# To start the 'sensorcam-munich' docker stack from scratch remove
# all corresponding containers and their persistant volumes
# 141119wss

echo -n "Do you really want to reset all sensorcamp docker containers? (y/n) "
read ANSWER
if [ "$ANSWER" != "${ANSWER#[Nn]}" ]; then
	exit 0
fi

if [ -n "`docker ps | grep sensorcamp-munich_`" ]; then
	echo "The docker stack is currently running, stop it first with 'docker-compose stop'."
	exit 1
fi

if [ -n "`docker network ls | grep bridge | grep sensorcamp-munich`" ]; then
	echo -n "Removing sensorcamp bridge interface..."
	docker network rm sensorcamp-munich_default 
fi


if [ -z "`docker container ls -a | grep sensorcamp-munich_`" ]; then
	echo "No sensorcamp containers found to be reset...exiting."
	exit 0
fi

docker container ls -a | grep sensorcamp-munich_ | while read LINE
do
	C_ID=`echo $LINE | awk '{ print $1 }'`
	C_NAME=`echo $LINE | awk '{ print $NF }'`
	echo -n "Removing docker container $C_NAME..."
	docker container rm $C_ID
done

docker volume ls | grep local | grep sensorcamp-munich_ | while read LINE
do
	V_NAME=`echo $LINE | awk '{ print $2 }'`
	echo -n "Removing docker volume "
	docker volume rm $V_NAME
done

exit 0
