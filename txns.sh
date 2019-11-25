#!/bin/bash

echo "Press [CTRL+C] to stop.."
while :
do
  docker exec quorum-examples_node1_1 geth --exec "loadScript('examples/samples/simple-event/private-generate-events.js')" attach qdata/dd/geth.ipc
  docker exec quorum-examples_node1_1 geth --exec "loadScript('examples/samples/simple-event/public-generate-events.js')" attach qdata/dd/geth.ipc

  echo "Sleeping 3 secs"
  sleep 3
done