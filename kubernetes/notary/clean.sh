# Delete deployments
# kubectl -n corda delete -f statefull-node.yaml --force
kubectl -n corda delete -f deployment-node.yaml --force

# Delete volumes
kubectl delete -f  node-volume.yaml --force

# Dekete configmap
kubectl delete -n corda configmap notary-conf --force

# Delete Postgress
kubectl -n corda delete -f deployment-postgres.yaml --force

# Delete Secrets
kubectl -n corda delete secret secret-notarydb --force
kubectl -n corda delete secret notary-secrets --force

# Delete namspace
# kubectl delete ns corda

echo Done cleaning