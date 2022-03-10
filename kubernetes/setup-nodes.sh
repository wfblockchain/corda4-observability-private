# Create namespace
bash -c "./create-ns.sh"

echo "\nsetup notary"
cd notary/
bash -c "./setup.sh"

echo "\nsetup partya"
cd ../partya/
bash -c "./setup.sh"

echo "\nsetup partyb"
cd ../partyb/
bash -c "./setup.sh"

echo "\ndone"