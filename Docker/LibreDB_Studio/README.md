## LibreDB Studio

**LibreDB Studio** — это открытая (MIT-лицензия) веб-IDE для работы с базами данных, которая разворачивается как контейнер Docker рядом с самой базой, а не на машине разработчика. По сути, это «браузерный DataGrip/DBeaver» — единая точка входа для запросов, визуализации и администрирования

    Вместо того чтобы каждый разработчик устанавливал десктопное приложение и искал строки подключения, вы разворачиваете один контейнер на сервере (или в облаке) рядом с базой. Пользователи заходят через браузер — включая мобильные устройства, что актуально для «горящих» запросов

### 1. Создание и запуск LibreDB Studio

```shell
docker run -p 3000:3000 ghcr.io/libredb/libredb-studio:latest
```

![Screen](/Docker/LibreDB_Studio/img/image.png)

в консоле вы увидите сгенерированные автоматически e-mail и пароль, которые введёте в Sing In интерфейса приложения в [браузере http://localhost:3000](http://localhost:3000)

![Screen](/Docker/LibreDB_Studio/img/image2.png)
![Screen](/Docker/LibreDB_Studio/img/3.png)

или с заданными заранее e-mail и пароль (Git-Bash/Linux)
```shell
docker run -d \
  --name libredb-studio \
  -p 3000:3000 \
  -e ADMIN_EMAIL=admin@example.com \
  -e ADMIN_PASSWORD=YourStrongPassword \
  -e JWT_SECRET=your-random-32-char-secret-string \
  ghcr.io/libredb/libredb-studio:latest
```
где `admin@example.com` и `YourStrongPassword` ваши email и пароль

Чтобы выйти из проекта в консоле, выполните `Ctrl+C`

### 2. Удалить проект

Получаем имя
```shell
docker ps -a
```
![Screen](/Docker/LibreDB_Studio/img/4.png)

останавливаем его, если запущен
```shell
docker stop competent_sinoussi
```
![Screen](/Docker/LibreDB_Studio/img/5.png)

удаляем контейнер
```shell
docker rm competent_sinoussi
```

![Screen](/Docker/LibreDB_Studio/img/6.png)

получаем имя образа
```shell
docker images
```
![Screen](/Docker/LibreDB_Studio/img/7.png)

и удаляем
```shell
docker image rm ghcr.io/libredb/libredb-studio:latest
```

![Screen](/Docker/LibreDB_Studio/img/8.png)

### Полезные ссылки

- [LibreDB Studio - анонс новой версии](https://www.opennet.ru/opennews/art.shtml?num=66216)