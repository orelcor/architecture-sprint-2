#!/bin/bash

###
# Инициализируем replica set для конфиг-серверов (достаточно на одном из инстансов)
###

docker exec -i sharding-repl-cache-config-1 mongosh --port 27019 <<EOL
rs.initiate(
{
    _id : "config_server",
    configsvr: true,
    members: [
        { _id : 0, host : "sharding-repl-cache-config-1:27019" },
        { _id : 1, host : "sharding-repl-cache-config-2:27019" }
    ]
}
);
EOL



