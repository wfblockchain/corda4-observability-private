echo "set fluentd configmap\n"
# kubectl -n corda delete -f fluentd-configmap.yaml
# kubectl -n corda apply -f fluentd-configmap.yaml
kubectl -n corda create -f fluentd-configmap.yaml

echo "set fluentd rbac\n"
kubectl -n corda create -f fluentd-rbac.yaml

echo "set fluentd\n"
kubectl -n corda create -f fluentd.yaml
# ls /var/log/containers/partya-*.log -pla
# cat /var/log/pods/corda_partya-696cd4659f-bncql_4244b2cb-912f-44b9-84f5-a9b1e2542bac/corda/0.log