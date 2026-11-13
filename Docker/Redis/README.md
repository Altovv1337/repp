## База данных Redis

> - **Никогда в разработке не используйте русские имена файлов и каталогов!**
> - **Никогда в разработке не используйте пробелы и спец.символы в именах файлов и каталогов!**
> - **Создание проекта лучше начать с "чистого листа", предварительно остановив и удалив все другие контейнеры и образы!**

Запуск **Redis**
```shell
docker run -d --name my-redis -p 6379:6379 redis:alpine
```

![screen](/Docker/Redis/img/1.png)

Подключиться к **Redis CLI**
```shell
docker exec -it my-redis redis-cli
```

Внутри Redis: ping → PONG, SET key value, GET key - ?

![screen](/Docker/Redis/img/2.png)