# Delete deployments
kubectl -n corda delete -f statefull-node.yaml

# Delete volumes
kubectl delete -f  node-volume.yaml

# Dekete configmap
kubectl delete -n corda configmap partya-conf

# Delete Postgress
kubectl -n corda delete -f deployment-postgres.yaml

# Delete Screts
kubectl -n corda delete secret secret-partyadb
kubectl -n corda delete secret partya-secrets

# Delete namspace
# kubectl delete ns corda

echo Done cleaning