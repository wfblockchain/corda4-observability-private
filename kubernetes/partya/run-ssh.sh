  # Run first the port forwarding from the script port-forward.sh
  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no user@localhost -p 2222

  # Run the following in the crashell 
  # flow start CashIssueAndPaymentFlow amount: 1000 GBP, issueRef: TestTransaction, recipient: PartyB, anonymous: false, notary: Notary