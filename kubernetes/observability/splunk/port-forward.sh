# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/

# in another shell connect to sshd. Look at the script run-ssh.sh
# kubectl -n corda port-forward statefulset.apps/partya  2222:2222
kubectl -n corda port-forward deployment/splunkenterprise  8000:8000