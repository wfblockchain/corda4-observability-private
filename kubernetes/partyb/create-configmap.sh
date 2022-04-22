kubectl delete -n corda configmap partyb-conf
kubectl create -n corda configmap partyb-conf \
        --from-file=persistenceMvDb=./configFiles/persistence.mv.db \
        --from-file=persistenceTraceDb=./configFiles/persistence.trace.db \
        --from-file=network-parameters=./configFiles/network-parameters \
        --from-file=addtional-node1=./configFiles/additional-node-infos/nodeInfo-7B8AF0AFE12D3B3993C45192A142CF0C30CC712BD66A8EF34F152A377D07AFEB \
        --from-file=addtional-node2=./configFiles/additional-node-infos/nodeInfo-777DA369F066FE34BEDE3E6334A1006A4026A02DD76AFA798204BD015C9965DE \
        --from-file=addtional-node3=./configFiles/additional-node-infos/nodeInfo-E4477B559304AADFC0638772C0956A38FA2E2A7A5EB0E65D0D83E5884831879A \
        --from-file=node-info=./configFiles/nodeInfo-777DA369F066FE34BEDE3E6334A1006A4026A02DD76AFA798204BD015C9965DE \
        --from-file=log4j2=./configFiles/log4j2-files.xml
