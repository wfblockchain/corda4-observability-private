FROM corda/corda-zulu-java1.8-4.8.6

USER "root"

## Add packages, clean cache, create dirs, create corda user and change ownership
RUN apt-get update && \
    apt-get install -y wget

USER "corda"

CMD ["sh", "-c", "java -jar /opt/corda/bin/corda.jar run-migration-scripts --core-schemas --app-schemas -f /etc/corda/node.conf ; java -jar /opt/corda/bin/corda.jar --base-directory /opt/corda -f /etc/corda/node.conf"]

