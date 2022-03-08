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

3. This folder contains the corda.jar open source and to build it just run the script **`buildForKubernete.sh`**
   
   this produces the following output
   ```
   $ ./buildForKubernete.sh
   Build Kubernets
   [+] Building 0.8s (12/12) FINISHED                                                                                                                                                                       
   => [internal] load build definition from Dockerfile.Kubernete                                                                                                                                      0.0s
   => => transferring dockerfile: 47B                                                                                                                                                                 0.0s
   => [internal] load .dockerignore                                                                                                                                                                   0.0s
   => => transferring context: 2B                                                                                                                                                                     0.0s
   => [internal] load metadata for docker.io/azul/zulu-openjdk-centos:8u312                                                                                                                           0.7s
   => [1/7] FROM docker.io/azul/zulu-openjdk-centos:8u312@sha256:fa643de6156e7b9d6543a62950495bc7a3f7737544a863b04bc0ea9b8266b6a5                                                                     0.0s
   => [internal] load build context                                                                                                                                                                   0.0s
   => => transferring context: 135B                                                                                                                                                                   0.0s
   => CACHED [2/7] RUN yum install -y bash curl unzip &&     rm -rf /var/lib/apt/lists/* &&     mkdir -p /opt/corda/persistence &&     mkdir -p /opt/corda/artemis &&     mkdir -p /opt/corda/certif  0.0s
   => CACHED [3/7] COPY --chown=corda:corda corda-4.8.6.jar /opt/corda/bin/corda.jar                                                                                                                  0.0s
   => CACHED [4/7] COPY --chown=corda:corda run-corda.sh /opt/corda/bin/run-corda                                                                                                                     0.0s
   => CACHED [5/7] COPY --chown=corda:corda start-corda.sh /opt/corda/bin/start-corda                                                                                                                 0.0s
   => CACHED [6/7] COPY --chown=corda:corda migration.sh /opt/corda/bin/migration                                                                                                                     0.0s
   => CACHED [7/7] WORKDIR /opt/corda                                                                                                                                                                 0.0s
   => exporting to image                                                                                                                                                                              0.0s
   => => exporting layers                                                                                                                                                                             0.0s
   => => writing image sha256:1a6545f9b9773ffcf9d875e32cc00d657b88a4acd108f8184e9e4881e8fbd169                                                                                                        0.0s
   => => naming to docker.io/library/corda:4.8.6                                                                                                                                                      0.0s

   Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them

   Remove old image

   Load new image   
   ```

4. For testing purposes a **`docker-compose.yml`** is available along with the scripts to **`start.sh`** and to **`stop.sh`**. This startup a node for Notary.
