kubectl delete -f deployment-node.yaml
kubectl create -f deployment-node.yaml
kubectl get pods
kubectl describe deployments.apps notary   
# kubectl logs  notary-59fb679f74-vmb4c  
