# Create namspace
# kubectl create ns corda

# Create secrets
./create-secrets.sh

# Create configmap
./create-configmap.sh

# Create volume
kubectl create -f  node-volume.yaml

# Create Postgress
kubectl -n corda create -f deployment-postgres.yaml

# Create state full node
kubectl -n corda create -f statefull-node.yaml --save-config

# list cordapps
kubectl -n corda exec -it partyb-0 bash -- ls cordapps/  -pla
#list all file
kubectl -n corda get pod  && kubectl -n corda logs partyb-0