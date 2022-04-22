echo "Build Kubernets"
docker build -f Dockerfile.fluentd . -t fluentd:v1.14.5-1.0
echo "\nRemove old image"

minikube image rm docker.io/library/fluentd:v1.14.5-1.0  
echo "\nLoad new image"
minikube image load docker.io/library/fluentd:v1.14.5-1.0