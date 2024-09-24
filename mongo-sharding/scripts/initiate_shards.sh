#!/bin/bash

###
# Инициализируем replica set для шардов на каждом из них
###

docker compose exec -T shard1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs01",
      members: [
        { _id : 0, host : "mongo-sharding-shard1-1:27018" }
      ]
    }
);
EOF

docker compose exec -T shard2 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs02",
      members: [
        { _id : 0, host : "mongo-sharding-shard2-1:27018" }
      ]
    }
);
EOF
