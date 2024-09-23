#!/bin/bash

###
# Инициализируем replica set для конфиг-серверов на каждом инстансе
###

docker compose exec -T router mongosh --port 27017 <<EOF
sh.addShard("rs01/mongo-sharding-shard1-1:27018")
sh.addShard("rs02/mongo-sharding-shard2-1:27018")
sh.enableSharding("somedb")
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
EOF
