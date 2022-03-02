  # Kubernetes for Corda
  
This project contains scripts to setup local corda network based on local image of corda. Build first the image based on the instructions of docker-centos

1. Corda need PKI material and configuration files. For this execute the script **`create-configmap.sh`** this will produce a file **`node-conf-configmap.yaml`**
   
2. Deploy Notary by running the script **`deploy-node.sh`**

## Notes
* Force to pull local docker image. Use the **`imagePullPolicy: Never`** in spec section for deployment yaml file
* Do not include node-info file. This file is automaticaly created when the node start and also added in the additional-info folders


4. Verify if the pods running
   ```
   $ kubectl get pods
   NAME                      READY   STATUS    RESTARTS   AGE
   notary-7b4b68b4f5-4cmxc   1/1     Running   0          25s
   ```


5. Get logs
   ```
   $ kubectl  logs notary-7b4b68b4f5-4cmxc 

      ______               __
   / ____/     _________/ /___ _
   / /     __  / ___/ __  / __ `/         What you can buy for a dollar these
   / /___  /_/ / /  / /_/ / /_/ /          days is absolute non-cents! 
   \____/     /_/   \__,_/\__,_/

   --- Corda Open Source 4.8.6 (9f02b41) -------------------------------------------------------------


   Logs can be found in                    : /opt/corda/logs
   Running database schema migration scripts ...
   Database migration scripts for core and app schemas complete. There are no outstanding database changes.

      ______               __
   / ____/     _________/ /___ _
   / /     __  / ___/ __  / __ `/         Check your contracts carefully. The fine print
   / /___  /_/ / /  / /_/ / /_/ /          is usually a clause for suspicion 
   \____/     /_/   \__,_/\__,_/

   --- Corda Open Source 4.8.6 (9f02b41) -------------------------------------------------------------


   Logs can be found in                    : /opt/corda/logs
   ! ATTENTION: This node is running in development mode!  This is not safe for production deployment.
   Advertised P2P messaging addresses      : notary:10200
   RPC connection address                  : 0.0.0.0:10201
   RPC admin connection address            : 0.0.0.0:10202
   Loaded 0 CorDapp(s)                     : 
   Node for "Notary" started up and registered in 21.35 sec
   Running P2PMessaging loop
   ```

6. Run describe command
   ```
   $ kubectl describe deployments.apps notary  
   Name:                   notary
   Namespace:              default
   CreationTimestamp:      Mon, 28 Feb 2022 11:28:40 -0800
   Labels:                 app=notary
   Annotations:            deployment.kubernetes.io/revision: 1
   Selector:               app=notary
   Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
   StrategyType:           RollingUpdate
   MinReadySeconds:        0
   RollingUpdateStrategy:  25% max unavailable, 25% max surge
   Pod Template:
   Labels:  app=notary
   Containers:
      corda:
      Image:        corda:4.8.6
      Port:         <none>
      Host Port:    <none>
      Environment:  <none>
      Mounts:
         /etc/corda/node.conf from vol1 (rw,path="conf")
         /opt/corda/additional-node-infos/nodeInfo-7B8AF0AFE12D3B3993C45192A142CF0C30CC712BD66A8EF34F152A377D07AFEB from vol1 (rw,path="addtional-node1")
         /opt/corda/additional-node-infos/nodeInfo-E4477B559304AADFC0638772C0956A38FA2E2A7A5EB0E65D0D83E5884831879A from vol1 (rw,path="addtional-node3")
         /opt/corda/certificates/nodekeystore.jks from vol1 (rw,path="nodekeystore")
         /opt/corda/certificates/sslkeystore.jks from vol1 (rw,path="sslkeystore")
         /opt/corda/certificates/truststore.jks from vol1 (rw,path="truststore")
         /opt/corda/network-parameters from vol1 (rw,path="network-parameters")
   Volumes:
      vol1:
      Type:      ConfigMap (a volume populated by a ConfigMap)
      Name:      notaryconf
      Optional:  false
   Conditions:
   Type           Status  Reason
   ----           ------  ------
   Available      True    MinimumReplicasAvailable
   Progressing    True    NewReplicaSetAvailable
   OldReplicaSets:  <none>
   NewReplicaSet:   notary-7b4b68b4f5 (1/1 replicas created)
   Events:
   Type    Reason             Age   From                   Message
   ----    ------             ----  ----                   -------
   Normal  ScalingReplicaSet  79s   deployment-controller  Scaled up replica set notary-7b4b68b4f5 to 1
   ```
7. bash to the pod
   ```
   $ kubectl exec -it notary-7b4b68b4f5-4cmxc bash
   kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
   bash-4.2$ ls
   additional-node-infos  bin      certificates  djvm     logs                nodeInfo-777DA369F066FE34BEDE3E6334A1006A4026A02DD76AFA798204BD015C9965DE  persistence.mv.db     process-id
   artemis                brokers  cordapps      drivers  network-parameters  persistence                                                                persistence.trace.db
   bash-4.2$ 
   ```
8. create port-forward
   ```
   kubectl port-forward deployment/partya 2222:2222
   ```
9. in another shell connect to sshd
    ```
     ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@localhost -p 2222
    ```
10. Replace docker image
    ```
    minikube image rm docker.io/library/corda:4.8.6   
    minikube image load docker.io/library/corda:4.8.6   
    ```