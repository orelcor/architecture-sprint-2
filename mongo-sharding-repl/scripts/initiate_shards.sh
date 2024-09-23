#!/bin/bash

###
# Инициализируем replica set для шардов на каждом из них
###

docker exec -i mongo-sharding-repl-shard1-1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs01",
      members: [
        { _id : 0, host : "mongo-sharding-repl-shard1-1:27018" }
      ]
    }
);
EOF


docker exec -i mongo-sharding-repl-shard2-1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs02",
      members: [
        { _id : 0, host : "mongo-sharding-repl-shard2-1:27018" }
      ]
    }
);
EOF
