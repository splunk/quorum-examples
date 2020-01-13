#!/bin/bash
QUORUM_CONSENSUS=raft

docker-compose pull
docker-compose up -d

docker exec splunk /bin/bash -c ""

until docker logs splunk | grep -m 1 'Ansible playbook complete'
do
  echo 'Waiting for splunk to start'
  sleep 5
done

echo "Restarting Splunk..."
docker exec splunk /bin/bash -c 'sudo mv /opt/splunk/etc/apps/splunk-app-quorum/default/inputs.conf.example /opt/splunk/etc/apps/splunk-app-quorum/default/inputs.conf'
docker exec splunk /bin/bash -c 'sudo mv /opt/splunk/etc/apps/splunk-app-quorum/default/indexes.conf.example /opt/splunk/etc/apps/splunk-app-quorum/default/indexes.conf'
docker exec splunk /bin/bash -c 'sudo /opt/splunk/bin/splunk restart'

echo "Deploying public and private contracts..."
docker exec quorum-examples_node1_1 geth --exec "loadScript('examples/private-contract.js')" attach qdata/dd/geth.ipc
docker exec quorum-examples_node1_1 geth --exec "loadScript('examples/public-contract.js')" attach qdata/dd/geth.ipc

echo "Starting transaction generator in background..."
nohup ./txns.sh &