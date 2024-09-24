#!/bin/bash

###
# Инициализируем кластер redis (на любой ноде) - НЕ НАДО ЗАПУСКАТЬ :)
###

docker compose exec -T redis bash <<EOF
echo "yes" | redis-cli --cluster create sharding-repl-cache-redis-1:6379 \
  sharding-repl-cache-redis-2:6379 \
  sharding-repl-cache-redis-3:6379 \
  sharding-repl-cache-redis-4:6379 \
  sharding-repl-cache-redis-5:6379 \
  sharding-repl-cache-redis-6:6379 \
  --cluster-replicas 1
EOF
