echo "\nreset notary"
cd notary/
bash -c "./clean.sh"

echo "\nreset partya"
cd ../partya/
bash -c "./clean.sh"

echo "\nreset partyb"
cd ../partyb/
bash -c "./clean.sh"

# Delete namespace
cd ..
bash -c "./delete-ns.sh"

echo "\ndone"