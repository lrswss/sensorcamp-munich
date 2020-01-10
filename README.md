## Docker stack including all software components to run a private LoRaWAN infrastructure on a Raspberry Pi

It's based on the docker-compose.yaml from the [ChirpStack](https://github.com/brocaar/chirpstack-docker).
project but also includes [Node-RED](https://nodered.org) and the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server)
which the OCG [SensorThings API stanadard](https://www.opengeospatial.org/standards/sensorthings) to store
sensor data 'the right way'.

The ChirpStack and the FROST-Server are sharing the included [PostgreSQL](https://postgresql.org) instance. Node-RED is basically
used to turn the sensor data published via [MQTT](https://en.wikipedia.org/wiki/MQTT) by the ChirpStack application server into [observations](https://docs.opengeospatial.org/is/15-078r6/15-078r6.html#31)
which are then posted via REST API to the FROST-Server.

To run the stack on your Raspberry Pi just clone the repository, open the file `docker-compose.yaml`
with a text editor and replace the ip address for the option `serviceRootUrl` with the ip address
of your Raspberry Pi. Start the docker stack with `docker-compose up` in this directory and
grab a coffee. Docker will first download all required docker images (about 1.5 GB) and then
start eight services altogether. Don't worry about intermediate `ping PostgreSQL database` errors
during the initial setup process, it takes a while to create and configure a PostgreSQL instance
on a Raspberry Pi. Same holds true for the initial deployment of the FROST-Server (Java/Tomcat). 

Eventually, when the load on your Raspberry Pi has settled (check with `top` in another terminal
window), you can connect to the ChirpStack UI with your favourite webbrowser at `http://<ip_addr_raspi>:8000/` 
replacing `<ip_addr_raspi>` with the current ip address of your Raspberry Pi. The FROST-Servers
RESTful API is available at `http://<ip_addr_raspi>:8080/FROST-Server/` and Node-RED at
`http://<ip_addr_raspi>:1880`.

The subdirectory `helper` contains a few shell scripts to reset the stack if you want to start
from scratch, to remove it altogether including all docker images and to grand the stack components
full access to the internet, for example if you need to install additional Node-RED nodes.

This stack was composed for a [barcamp](https://barcamptools.eu/SensorCamp/) session on LoRaWAN infrastructure
presented on the "2. Fachtagung Sensordaten" on the 13./14.11.2019 in Munich.
