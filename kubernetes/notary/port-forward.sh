# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/

# in another shell connect to sshd. Look at the script run-ssh.sh
kubectl -n corda port-forward statefulset.apps/notary  2222:2222