echo "Build Kubernets"
docker build -f Dockerfile.cordapps . -t cordapps:4.8.6 
echo "\nRemove old image"

minikube image rm docker.io/library/cordapps:4.8.6   
echo "\nLoad new image"
minikube image load docker.io/library/cordapps:4.8.6   