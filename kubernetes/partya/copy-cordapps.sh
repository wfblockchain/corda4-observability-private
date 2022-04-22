kubectl -n corda cp ../../docker/docker-centos/cordapps corda/partya-0:.
kubectl -n corda delete pod partya-0
kubectl -n corda cp ../../docker/docker-centos/configFiles/log4j2.xml corda/partya?:/etc/corda/