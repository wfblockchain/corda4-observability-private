echo "setup elastic\n"
kubectl -n corda create -f ./elastic/deployment-elastic.yaml
kubectl -n corda get all -l app=elasticsearch

echo "setup kibana\n"
kubectl -n corda create -f ./kibana/deployment-kibana.yaml
kubectl -n corda get all -l app=kibana

echo "setup splunk\n"
kubectl -n corda create -f ./splunk/deployment-splunk.yaml
kubectl -n corda get all -l app=splunk

echo "setup prometheus config map"
# kubectl create -n corda configmap prometheus --from-file=prometheus=../observability-poc/docker/prometheus/prometheus.yaml
kubectl -n corda -f ./prometheus/configmap-prometheus.yaml

kubectl -n corda get configmap prometheus
kubectl -n corda create -f ./prometheus/deployment-prometheus.yaml
kubectl -n corda get all -l app=prometheus

echo "setup grafana\n"
# kubectl -n corda delete -f ./grafana/deployment-grafana.yaml
kubectl -n corda create -f ./grafana/deployment-grafana.yaml
kubectl -n corda get all -l app=grafana

kubectl -n corda get po,svc,deploy