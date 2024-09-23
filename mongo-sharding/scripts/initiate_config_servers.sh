#!/bin/bash

###
# Инициализируем replica set для конфиг-серверов на каждом инстансе
###

docker compose exec -T config mongosh --port 27019 <<EOF
rs.initiate(
{
    _id : "config_server",
    configsvr: true,
    members: [
        { _id : 0, host : "mongo-sharding-config-1:27019" },
        { _id : 1, host : "mongo-sharding-config-2:27019" }
    ]
}
);
EOF
