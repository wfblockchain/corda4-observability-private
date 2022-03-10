# Create namspace
# kubectl create ns corda

# Create configmap
./create-configmap.sh

# Create volume
kubectl create -f  node-volume.yaml

# Create state full node
kubectl -n corda create -f statefull-node.yaml --save-config
echo "copying cordapps...."
bash -c "sleep 20"

# Copy cordapps
kubectl cp ../../corda-utilities/cordapps/corda-finance-contracts-4.8.6.jar corda/partyb-0:/opt/corda/cordapps/corda-finance-contracts-4.8.6.jar
kubectl cp ../../corda-utilities/cordapps/corda-finance-workflows-4.8.6.jar corda/partyb-0:/opt/corda/cordapps/corda-finance-workflows-4.8.6.jar

echo "sleeping...."
bash -c "sleep 15"
echo "restarting...."

kubectl -n corda apply -f statefull-node.yaml 

# list cordapps
kubectl -n corda exec -it partyb-0 bash -- ls cordapps/  -pla
#list all file
kubectl -n corda get pod  && kubectl -n corda logs partyb-0