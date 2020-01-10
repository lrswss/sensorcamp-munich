#!/bin/sh
# This script will remove all local images of the 'sensorcamp-munich'
# LoRaWAN/FROST docker stack. Corresponding containers must be removed 
# before calling this script (-> reset-stack.sh). Script can cause
# error messages if local images for node-red, mosquitto and redis
# are used by containers not part of the 'sensorcam-munich' stack.
# 151119wss

echo -n "Do you really want to remove all sensorcamp docker images from your system? (y/n) "
read ANSWER
if [ "$ANSWER" != "${ANSWER#[Nn]}" ]; then
	exit 0
fi

if [ -z "`docker image ls -a | grep ^bettwanze/`" ]; then
	echo "No images found that need to be removed...exiting."
	exit 0
fi

docker image ls -a | grep ^bettwanze/ | while read LINE
do
	I_ID=`echo $LINE | awk '{ print $3 }'`
	I_NAME=`echo $LINE | awk '{ print $1 }'`
	echo "Removing docker image $I_NAME..."
	docker image rm $I_ID
done

for IMAGE in eclipse-mosquitto redis nodered
do
	I_ID=`docker image ls -a | grep ^$IMAGE | awk '{ print $3 }'`
	if [ -n "$I_ID" ]; then
		echo -n "Do you really want to remove docker image $IMAGE ($I_ID)? (y/n) "
		read ANSWER
		if [ "$ANSWER" != "${ANSWER#[Yy]}" ]; then
			echo -n "Removing docker image $IMAGE "
			docker image rm $I_ID
		else
			echo "Ok, skipping docker image $IMAGE ($I_ID)."
		fi
	fi
done

exit 0
