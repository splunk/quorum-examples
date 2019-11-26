#!/bin/bash

echo "Press [CTRL+C] to stop.."
while :
do
  NODE=$(((RANDOM % 7) + 1))
  echo "Connecting to random node: $NODE"
  docker exec quorum-examples_node${NODE}_1 geth --exec "loadScript('examples/samples/simple-event/private-contract-event.js')" attach qdata/dd/geth.ipc
  docker exec quorum-examples_node${NODE}_1 geth --exec "loadScript('examples/samples/simple-event/public-contract-event.js')" attach qdata/dd/geth.ipc
  docker exec quorum-examples_node${NODE}_1 geth --exec "loadScript('examples/samples/simple-event/public-generate-events.js')" attach qdata/dd/geth.ipc
  docker exec quorum-examples_node${NODE}_1 geth --exec "loadScript('examples/samples/simple-event/private-generate-events.js')" attach qdata/dd/geth.ipc
  docker exec quorum-examples_node${NODE}_1 geth --exec "loadScript('examples/samples/simple-event/private-generate-events.js')" attach qdata/dd/geth.ipc

  echo "Sleeping 30 secs"
  sleep 30
done