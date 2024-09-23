## Конфиг сервер
Инициализировать replica set для конфиг-серверов на каждом инстансе:

1. `docker exec -it mongo-sharding-config-server-1 mongosh --port 27019`
2. Команда:
```
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
```

3. `docker exec -it mongo-sharding-config-server-1 mongosh --port 27019`
4. Команда:
```
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
```

## Шарды
Инициализировать replica set для шардов на каждом из них:
1. `docker exec -it "mongo-sharding-shard-1 mongosh --port 27018`
2. Команда:
```
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "mongo-sharding-shard-1:27018" },
        { _id : 1, host : "mongo-sharding-shard-2:27018" }
      ]
    }
);
```

3. `docker exec -it mongo-sharding-shard2 mongosh --port 27018`
4. Команда:
```
rs.initiate(
    {
      _id : "rs01",
      members: [
        { _id : 0, host : "mongo-sharding-shard1-1:27018" }
      ]
    }
);
```

## Роутеры

На каждом роутере:
- `docker exec -it mongos_router mongo-sharding-router-1 --port 27017`
- `docker exec -it mongos_router mongo-sharding-router-2 --port 27017`

1. Привяжите шарды:
- `sh.addShard( "shard1/mongo-sharding-shard-1:27018");` 
- `sh.addShard( "shard1/mongo-sharding-shard-1:27018");`
2. Создайте коллекцию с шардингом:
- `sh.enableSharding("somedb");`
- `sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );`
3. Наполните тестовыми данными:
- `use somedb`
- `for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})`

