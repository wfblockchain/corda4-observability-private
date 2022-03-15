# Create DB Secrets
kubectl create secret -n corda generic secret-partybdb --from-literal='db-password=test' 

# Create Secrets from file
kubectl -n corda delete secret partyb-secrets
kubectl -n corda create secret generic partyb-secrets \
        --from-file=conf=./configFiles/partyb-node.conf \
        --from-file=nodekeystore=./configFiles/certificates/nodekeystore.jks \
        --from-file=sslkeystore=./configFiles/certificates/sslkeystore.jks \
        --from-file=truststore=./configFiles/certificates/truststore.jks

   