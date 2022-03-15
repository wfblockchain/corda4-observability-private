# Delete deployments
kubectl -n corda delete -f statefull-node.yaml

# Delete volumes
kubectl delete -f  node-volume.yaml

# Dekete configmap
kubectl delete -n corda configmap partya-conf

# Delete Postgress
kubectl -n corda delete -f deployment-postgress.yaml

# Delete namspace
# kubectl delete ns corda

echo Done cleaning