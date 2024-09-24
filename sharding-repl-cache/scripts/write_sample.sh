#!/bin/bash

###
# Инициализируем replica set для конфиг-серверов на каждом инстансе
###

docker compose exec -T router mongosh --port 27017 <<EOF
use somedb;
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
EOF
