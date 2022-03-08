echo "Build Kubernets"
docker build -f Dockerfile.Kubernete . -t corda:4.8.6 
echo "\nRemove old image"

minikube image rm docker.io/library/corda:4.8.6   
echo "\nLoad new image"
minikube image load docker.io/library/corda:4.8.6   