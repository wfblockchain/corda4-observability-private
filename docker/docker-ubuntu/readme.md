# Docker file based on corda/corda-zulu-java1.8-4.8.6
This folder contains the corda.jar open source and to build it just run the script **`build.sh`**

For testing purposes a **`docker-compose.yml`** is available along with the scripts to **`start.sh`** and to **`stop.sh`**. This startup a node for Notary.

SSH into the PartyA node Crash shell:

```bash
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@localhost -p 2222
```