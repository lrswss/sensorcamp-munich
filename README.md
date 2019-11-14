## Docker stack including all software components to run a private LoRaWAN infrastructure on a Raspberry Pi

It's based on the docker-compose.yaml from the [ChirpStack](https://github.com/brocaar/chirpstack-docker).
project but also includes Node-RED and the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server)
which the OCG [SensorThings API stanadard](https://www.opengeospatial.org/standards/sensorthings) to store
sensor data 'the right way'.

The ChirpStack and the FROST-Server are sharing the included PostgreSQL instance. Node-RED is basically
used to turn the sensor data published via MQTT by the ChirpStack application server into OCG 'observations'
which are then posted via REST API to the FROST-Server.

This stack was composed for a [barcamp](https://barcamptools.eu/SensorCamp/) session on LoRaWAN infrastructure
presented on the "2. Fachtagung Sensordaten" on the 13./14.11.2019 in Munich.
