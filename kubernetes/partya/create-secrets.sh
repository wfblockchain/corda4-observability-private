# Create DB Secrets
kubectl create secret -n corda generic secret-partyadb --from-literal='db-password=test' 

# Create Secrets from file
kubectl -n corda delete secret partya-secrets
kubectl -n corda create secret generic partya-secrets \
        --from-file=conf=./configFiles/partya-node.conf \
        --from-file=nodekeystore=./configFiles/certificates/nodekeystore.jks \
        --from-file=sslkeystore=./configFiles/certificates/sslkeystore.jks \
        --from-file=truststore=./configFiles/certificates/truststore.jks

   