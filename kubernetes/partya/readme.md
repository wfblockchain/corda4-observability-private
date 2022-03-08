  # Kubernetes for Corda
  
This project contains scripts to setup local corda network based on local image of corda. Build first the image based on the instructions of docker-centos

1. Corda need PKI material and configuration files. For this execute the script **`create-configmap.sh`** this will produce a file **`node-conf-configmap.yaml`**
   
2. Deploy Notary by running the script **`deploy-node.sh`**

## Notes
* Force to pull local docker image. Use the **`imagePullPolicy: Never`** in spec section for deployment yaml file
* Do not include node-info file. This file is automaticaly created when the node start and also added in the additional-info folders


   
1. Verify if the folder exists **`/corda/partya`** 
   ```
   $ minikube  ssh ls /corda/partya
   ls: cannot access '/corda/partya': No such file or directory
   ssh: Process exited with status 2
   ```

2. Run the script **`./setup.sh`**
   
   This script creates the following
   - corda namespace
   - configuration files with certificates material
   - creates a persisted volume partya-pv and its claim partya-pvc to survive between nodes restarts
   - deploy the node as statefull
   - copy cordapps
   - show the log when nodes started
   ```
   cd kubernetes/partya/
   ./setup.sh
   ```
   
   This script produces the following output
   ```
   $ ./setup.sh 
   namespace/corda created
   Error from server (NotFound): configmaps "partya-conf" not found
   configmap/partya-conf created
   persistentvolumeclaim/partya-pvc created
   persistentvolume/partya-pv created
   statefulset.apps/partya created
   service/partya-cluster created
   copying cordapps....
   Defaulted container "corda" out of: corda, change-ownership-container (init)
   Defaulted container "corda" out of: corda, change-ownership-container (init)
   sleeping....
   restarting....
   statefulset.apps/partya configured
   service/partya-cluster unchanged
   Defaulted container "corda" out of: corda, change-ownership-container (init)
   total 372
   drwxr-xr-x  3 corda corda    100 Mar  7 23:38 ./
   drwxr-xr-x 15 corda corda    380 Mar  7 23:38 ../
   drwxr-xr-x  2 corda corda     40 Mar  7 23:33 config/
   -rw-r--r--  1 corda  3000 181591 Mar  7 23:38 corda-finance-contracts-4.8.6.jar
   -rw-r--r--  1 corda  3000 193161 Mar  7 23:38 corda-finance-workflows-4.8.6.jar
   NAME       READY   STATUS    RESTARTS   AGE
   partya-0   1/1     Running   0          37s

   *************************************************************************************************************************************
   *  All rights reserved.                                                                                                             *
   *  This software is proprietary to and embodies the confidential technology of R3 LLC ("R3").                                       *
   *  Possession, use, duplication or dissemination of the software is authorized only pursuant to a valid written license from R3.    *
   *  IF YOU DO NOT HAVE A VALID WRITTEN LICENSE WITH R3, DO NOT USE THIS SOFTWARE.                                                    *
   *************************************************************************************************************************************

      ______               __         _____ _   _ _____ _____ ____  ____  ____  ___ ____  _____
   / ____/     _________/ /___ _   | ____| \ | |_   _| ____|  _ \|  _ \|  _ \|_ _/ ___|| ____|
   / /     __  / ___/ __  / __ `/   |  _| |  \| | | | |  _| | |_) | |_) | |_) || |\___ \|  _|
   / /___  /_/ / /  / /_/ / /_/ /    | |___| |\  | | | | |___|  _ <|  __/|  _ < | | ___) | |___
   \____/     /_/   \__,_/\__,_/     |_____|_| \_| |_| |_____|_| \_\_|   |_| \_\___|____/|_____|

   --- Corda Enterprise Edition 4.8.6 (6bb405e) ------------------------------------------------

   Tip: If you don't wish to use the shell it can be disabled with the --no-local-shell flag

   Logs can be found in                    : /opt/corda/logs
   ! ATTENTION: If you make use of confidential identities, there is now a more secure way of storing the associated keys, but you have to explicitly enable it with the appropriate configuration. Review the documentation to see how this can be enabled via the `freshIdentitiesConfiguration` entry. Alternatively, you can disable this warning by setting `disableFreshIdentitiesWarning` to true in the node's configuration.
   Running database schema migration scripts ...
   Database migration scripts for core and app schemas complete. There are no outstanding database changes.
   $       
   ```

3. Run the script **`./clean.sh`**
   
   This does the following clean up steps
   - remove statefull app partya
   - remove service partya-cluster
   - remove perstisted volume claim and its volume
   - remove the configMap
   - remove the namespace corda
  
   it produces the following output
   ```
   statefulset.apps "partya" deleted
   service "partya-cluster" deleted
   persistentvolumeclaim "partya-pvc" deleted
   persistentvolume "partya-pv" deleted
   configmap "partya-conf" deleted
   namespace "corda" deleted
   Done cleaning
   ```


## Other kubernets commands
1. Verify if the pods running
   ```
   $ kubectl -n corda get pods
   NAME       READY   STATUS    RESTARTS   AGE
   partya-0   1/1     Running   0          3m15s
      ```


2. Get logs
   ```
   $ kubectl -n corda logs partya-0

   *************************************************************************************************************************************
   *  All rights reserved.                                                                                                             *
   *  This software is proprietary to and embodies the confidential technology of R3 LLC ("R3").                                       *
   *  Possession, use, duplication or dissemination of the software is authorized only pursuant to a valid written license from R3.    *
   *  IF YOU DO NOT HAVE A VALID WRITTEN LICENSE WITH R3, DO NOT USE THIS SOFTWARE.                                                    *
   *************************************************************************************************************************************

      ______               __         _____ _   _ _____ _____ ____  ____  ____  ___ ____  _____
   / ____/     _________/ /___ _   | ____| \ | |_   _| ____|  _ \|  _ \|  _ \|_ _/ ___|| ____|
   / /     __  / ___/ __  / __ `/   |  _| |  \| | | | |  _| | |_) | |_) | |_) || |\___ \|  _|
   / /___  /_/ / /  / /_/ / /_/ /    | |___| |\  | | | | |___|  _ <|  __/|  _ < | | ___) | |___
   \____/     /_/   \__,_/\__,_/     |_____|_| \_| |_| |_____|_| \_\_|   |_| \_\___|____/|_____|

   --- Corda Enterprise Edition 4.8.6 (6bb405e) ------------------------------------------------

   Tip: If you don't wish to use the shell it can be disabled with the --no-local-shell flag

   Logs can be found in                    : /opt/corda/logs
   ! ATTENTION: If you make use of confidential identities, there is now a more secure way of storing the associated keys, but you have to explicitly enable it with the appropriate configuration. Review the documentation to see how this can be enabled via the `freshIdentitiesConfiguration` entry. Alternatively, you can disable this warning by setting `disableFreshIdentitiesWarning` to true in the node's configuration.
   Running database schema migration scripts ...
   Database migration scripts for core and app schemas complete. There are no outstanding database changes.

   *************************************************************************************************************************************
   *  All rights reserved.                                                                                                             *
   *  This software is proprietary to and embodies the confidential technology of R3 LLC ("R3").                                       *
   *  Possession, use, duplication or dissemination of the software is authorized only pursuant to a valid written license from R3.    *
   *  IF YOU DO NOT HAVE A VALID WRITTEN LICENSE WITH R3, DO NOT USE THIS SOFTWARE.                                                    *
   *************************************************************************************************************************************

      ______               __         _____ _   _ _____ _____ ____  ____  ____  ___ ____  _____
   / ____/     _________/ /___ _   | ____| \ | |_   _| ____|  _ \|  _ \|  _ \|_ _/ ___|| ____|
   / /     __  / ___/ __  / __ `/   |  _| |  \| | | | |  _| | |_) | |_) | |_) || |\___ \|  _|
   / /___  /_/ / /  / /_/ / /_/ /    | |___| |\  | | | | |___|  _ <|  __/|  _ < | | ___) | |___
   \____/     /_/   \__,_/\__,_/     |_____|_| \_| |_| |_____|_| \_\_|   |_| \_\___|____/|_____|

   --- Corda Enterprise Edition 4.8.6 (6bb405e) ------------------------------------------------

   Tip: The config file format supports many useful features: https://github.com/typesafehub/config#using-hocon-the-json-superset

   Logs can be found in                    : /opt/corda/logs
   ! ATTENTION: If you make use of confidential identities, there is now a more secure way of storing the associated keys, but you have to explicitly enable it with the appropriate configuration. Review the documentation to see how this can be enabled via the `freshIdentitiesConfiguration` entry. Alternatively, you can disable this warning by setting `disableFreshIdentitiesWarning` to true in the node's configuration.
   ! ATTENTION: This node is running in development mode!  This is not safe for production deployment.
   Advertised P2P messaging addresses      : partya:10200
   RPC connection address                  : 0.0.0.0:10201
   RPC admin connection address            : 0.0.0.0:10202
   Loaded 2 CorDapp(s)                     : Workflow CorDapp: Corda Finance Demo version 1 by vendor R3 with licence Open Source (Apache 2), Contract CorDapp: Corda Finance Demo version 1 by vendor R3 with licence Open Source (Apache 2)
   Node for "PartyA" started up and registered in 26.3 sec
   SSH server listening on port            : 2222
   Running P2PMessaging loop
   $       
   ```

3. Run describe command
   ```
   $ kubectl describe -n corda statefulset.apps/partya 
   Name:               partya
   Namespace:          corda
   CreationTimestamp:  Mon, 07 Mar 2022 15:38:19 -0800
   Selector:           app=partya
   Labels:             app=partya
   Annotations:        <none>
   Replicas:           1 desired | 1 total
   Update Strategy:    RollingUpdate
   Partition:        0
   Pods Status:        1 Running / 0 Waiting / 0 Succeeded / 0 Failed
   Pod Template:
   Labels:  app=partya
   Init Containers:
      change-ownership-container:
      Image:      corda:4.8.6
      Port:       <none>
      Host Port:  <none>
      Command:
         /bin/sh
         -c
      Args:
         echo starting; /bin/mkdir -p /opt/corda/cordapps/config; /bin/chown -R 1000:1000 /opt/corda; echo done;
      Environment:  <none>
      Mounts:
         /opt/corda from data (rw)
   Containers:
      corda:
      Image:       corda:4.8.6
      Ports:       10003/TCP, 10004/TCP, 2222/TCP
      Host Ports:  0/TCP, 0/TCP, 0/TCP
      Limits:
         cpu:     1
         memory:  2Gi
      Requests:
         cpu:        500m
         memory:     1Gi
      Environment:  <none>
      Mounts:
         /etc/corda/node.conf from vol1 (rw,path="conf")
         /opt/corda from data (rw)
         /opt/corda/additional-node-infos/nodeInfo-777DA369F066FE34BEDE3E6334A1006A4026A02DD76AFA798204BD015C9965DE from vol1 (rw,path="addtional-node2")
         /opt/corda/additional-node-infos/nodeInfo-7B8AF0AFE12D3B3993C45192A142CF0C30CC712BD66A8EF34F152A377D07AFEB from vol1 (rw,path="addtional-node1")
         /opt/corda/certificates/nodekeystore.jks from vol1 (rw,path="nodekeystore")
         /opt/corda/certificates/sslkeystore.jks from vol1 (rw,path="sslkeystore")
         /opt/corda/certificates/truststore.jks from vol1 (rw,path="truststore")
         /opt/corda/network-parameters from vol1 (rw,path="network-parameters")
   Volumes:
      data:
      Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
      ClaimName:  partya-pvc
      ReadOnly:   false
      vol1:
      Type:       ConfigMap (a volume populated by a ConfigMap)
      Name:       partya-conf
      Optional:   false
   Volume Claims:  <none>
   Events:
   Type    Reason            Age    From                    Message
   ----    ------            ----   ----                    -------
   Normal  SuccessfulCreate  6m16s  statefulset-controller  create Pod partya-0 in StatefulSet partya successful
   $ 
   ```

4. bash to the pod
   ```
   $ kubectl -n corda exec -it partya-0 bash  
   kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
   Defaulted container "corda" out of: corda, change-ownership-container (init)
   bash-4.2$ ls -pla
   total 4364
   drwxr-xr-x 15 corda corda     400 Mar  7 23:39 ./
   drwxr-xr-x  1 root  root     4096 Mar  7 04:25 ../
   drwxr-xr-x  2 corda corda    4096 Mar  7 23:39 additional-node-infos/
   drwxr-xr-x  5 corda corda    4096 Mar  7 23:39 artemis/
   drwxr-xr-x  2 corda corda    4096 Mar  7 23:38 bin/
   drwxr-xr-x  3 corda corda      60 Mar  7 23:35 brokers/
   drwxr-xr-x  3 corda corda      60 Mar  7 23:33 .capsule/
   drwxr-xr-x  2 corda corda    4096 Mar  7 23:38 certificates/
   drwxr-xr-x  3 corda corda     100 Mar  7 23:38 cordapps/
   drwxr-xr-x  2 corda corda     580 Mar  7 23:38 djvm/
   drwxr-xr-x  2 corda corda    4096 Mar  7 04:25 drivers/
   drwxr-xr-x  2 corda corda    4096 Mar  7 23:38 logs/
   -rw-r--r--  1 root   2000    4490 Mar  7 23:38 network-parameters
   -rw-r--r--  1 corda  3000    4672 Mar  7 23:39 nodeInfo-E4477B559304AADFC0638772C0956A38FA2E2A7A5EB0E65D0D83E5884831879A
   drwxr-xr-x  2 corda corda    4096 Mar  7 04:25 persistence/
   -rw-r--r--  1 corda corda 4403200 Mar  7 23:44 persistence.mv.db
   -rw-r--r--  1 corda corda    8730 Mar  7 23:33 persistence.trace.db
   -rw-r--r--  1 corda  3000       2 Mar  7 23:38 process-id
   drwxr-xr-x  2 corda corda      40 Mar  7 23:33 shell-commands/
   drwxr-xr-x  2 corda corda      40 Mar  7 23:33 ssh/
   bash-4.2$ 
   ```

5. create port-forward
   ```
   kubectl port-forward deployment/partya 2222:2222
   ```

6. in another shell connect to sshd
    ```
     ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@localhost -p 2222
    ```

7.  Replace docker image
    ```
    minikube image rm docker.io/library/corda:4.8.6   
    minikube image load docker.io/library/corda:4.8.6   
    ```

8. Persistent Storage
   - Check storage class
   ```
   kubectl get storageclass

   03/07/22 15:49:23T:~$ kubectl get storageclass
   NAME                 PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
   standard (default)   k8s.io/minikube-hostpath   Delete          Immediate           false                  2d23h
   ```

   - Check PersistentVolume
   ```
   $ kubectl get pv
   NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM              STORAGECLASS   REASON   AGE
   partya-pv   2Gi        RWO            Retain           Bound    corda/partya-pvc   hostpath                24m
   ```
   
   - Check PersistentVolumeClaim
   ```
   03/07/22 15:50:52T:~$ kubectl get -n corda pvc
   NAME         STATUS   VOLUME      CAPACITY   ACCESS MODES   STORAGECLASS   AGE
   partya-pvc   Bound    partya-pv   2Gi        RWO            hostpath       12m
   ```

