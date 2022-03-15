# Create DB Secrets
kubectl create secret -n corda generic secret-notarydb --from-literal='db-password=test' 

# Create Secrets from file
kubectl -n corda delete secret notary-secrets
kubectl -n corda create secret generic notary-secrets \
        --from-file=conf=./configFiles/notary-node.conf \
        --from-file=nodekeystore=./configFiles/certificates/nodekeystore.jks \
        --from-file=sslkeystore=./configFiles/certificates/sslkeystore.jks \
        --from-file=truststore=./configFiles/certificates/truststore.jks

   