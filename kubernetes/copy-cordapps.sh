cd partya
./copy-cordapps.sh
cd ../partyb
./copy-cordapps.sh

echo *** list partya ***
kubectl -n corda exec -it partya-0  -- ls cordapps/

echo *** list partyb ***
kubectl -n corda exec -it partyb-0  -- ls cordapps/