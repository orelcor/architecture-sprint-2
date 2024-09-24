#!/bin/bash

###
# Инициализируем replica set для конфиг-серверов на каждом инстансе
###

docker exec -i mongo-sharding-repl-router-1 mongosh --port 27017 <<EOF
sh.addShard("rs01/shard1-a:27018");
sh.addShard("rs01/shard1-b:27018");
sh.addShard("rs02/shard2-a:27018");
EOF


docker exec -i mongo-sharding-repl-router-2 mongosh --port 27017 <<EOF
sh.addShard("rs01/shard1-a:27018");
sh.addShard("rs01/shard1-b:27018");
sh.addShard("rs02/shard2-a:27018");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
EOF