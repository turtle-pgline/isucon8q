#!/bin/bash

set -eux

cd $(cd $(dirname $0); pwd)

cd ../go
GOOS=linux GOARCH=amd64 go build src/torb/app.go

mv app torb

ssh -t root@150.95.216.44 "systemctl stop torb.go"
scp ./torb root@150.95.216.44:/home/isucon/torb/webapp/go/torb
ssh -t root@150.95.216.44 "chown isucon:isucon /home/isucon/torb/webapp/go/torb"
ssh -t root@150.95.216.44 "systemctl start torb.go"

echo "deployed!" | notify_slack
