# Create namspace
# kubectl create ns corda

# Create configmap
./create-configmap.sh

# Create volume
kubectl create -f  node-volume.yaml

# Create state full node
kubectl -n corda create -f statefull-node.yaml --save-config
bash -c "sleep 20"

# list cordapps
kubectl -n corda exec -it notary-0 bash -- ls cordapps/  -pla
#list all file
kubectl -n corda get pod  && kubectl -n corda logs notary-0