# Create namspace
kubectl create ns corda

# Create configmap
./create-configmap.sh

# Create volume
kubectl create -f  node-volume.yaml

# Create state full node
kubectl -n corda create -f statefull-node.yaml --save-config
echo "copying cordapps...."
bash -c "sleep 20"

# Copy cordapps
kubectl cp ../../corda-utilities/cordapps/corda-finance-contracts-4.8.6.jar corda/partya-0:/opt/corda/cordapps/corda-finance-contracts-4.8.6.jar
kubectl cp ../../corda-utilities/cordapps/corda-finance-workflows-4.8.6.jar corda/partya-0:/opt/corda/cordapps/corda-finance-workflows-4.8.6.jar

echo "sleeping...."
bash -c "sleep 15"
echo "restarting...."

kubectl -n corda apply -f statefull-node.yaml 
# minikube cp  corda-utilities/cordapps/corda-finance-contracts-4.8.6.jar /corda/partya/cordapps/corda-finance-contracts-4.8.6.jar
# minikube cp corda-utilities/cordapps/corda-finance-workflows-4.8.6.jar /corda/partya/cordapps/cordapps/corda-finance-workflows-4.8.6.jar
# minikube cp corda-utilities/cordapps/test.txt /corda/partya/tmp/test.txt
#
# kubectl is not possible
# 03/06/22 20:03:12T:~$ kubectl cp corda-utilities/cordapps/test.txt corda/partya-0:/opt/corda/tmp/test2.txt
# Defaulted container "corda" out of: corda, change-ownership-container (init)
# tar: test2.txt: Cannot open: Permission denied
# tar: Exiting with failure status due to previous errors
# command terminated with exit code 2

# list cordapps
kubectl -n corda exec -it partya-0 bash -- ls cordapps/  -pla
#list all file
kubectl -n corda get pod  && kubectl -n corda logs partya-0