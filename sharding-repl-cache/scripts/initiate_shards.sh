#!/bin/bash

###
# Инициализируем replica set для шардов на каждом из них
###

docker exec -i shard1-a mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs01",
      members: [
        { _id : 0, host : "shard1-a:27018" },
        { _id : 1, host : "shard1-b:27018" },
        { _id : 2, host : "shard1-c:27018" }
      ]
    }
);
EOF


docker exec -i shard2-a mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs02",
      members: [
        { _id : 0, host : "shard2-a:27018" },
        { _id : 1, host : "shard2-b:27018" },
        { _id : 2, host : "shard2-c:27018" }
      ]
    }
);
EOF
