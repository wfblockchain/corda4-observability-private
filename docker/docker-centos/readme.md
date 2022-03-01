# Docker file based on openjdk centos

1. Start minikube with the command **`minikube start`**

2. Next change the local Docker daemon to minikube Docker registry
   ```
   minikube docker-env  
   ```

   Apply these variable with the following command
   ```
   eval $(minikube -p minikube docker-env)
   ```

3. This folder contains the corda.jar open source and to build it just run the script **`build.sh`**

3. For testing purposes a **`docker-compose.yml`** is available along with the scripts to **`start.sh`** and to **`stop.sh`**. This startup a node for Notary.

```
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@localhost -p 2222
```