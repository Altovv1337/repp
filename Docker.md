## Шпаргалка по Docker
 
### Установка
 
**Windows 10–11**
```powershell
winget install Docker.DockerDesktop
```
- **Docker Desktop** должен быть запущен!
- Папка проекта должна быть в разрешённых для **Docker Desktop** дисках (`Settings` → `Resources` → `File Sharing`)
- Первый запуск может быть долгим
 
**Alt Linux 11**
```shell
apt-get install docker-engine docker-compose
```
**macOS**
```shell
brew install --cask docker
```
 
> ⚠️ В **Linux** не забудьте добавить пользователя в группу `docker`, чтобы работать без `sudo`:
> ```shell
> sudo usermod -aG docker $USER
> newgrp docker
> ```
> В **macOS** и **Windows** этого делать не нужно — Docker Desktop работает через виртуальную машину.
 
---
 
### Основные команды
 
#### Состояние и информация
 
Версия Docker:
```shell
docker version
```
или кратко:
```shell
docker --version
```
Мониторинг ресурсов в реальном времени:
```shell
docker stats
```
выйти из `stats` по **Ctrl+C**
 
Показать все контейнеры, включая остановленные:
```shell
docker ps -a
```
Показать все имеющиеся Docker-образы:
```shell
docker images
```
Быстрая демонстрация работы Docker:
```shell
docker run hello-world
```
Сводка по диску Docker:
```shell
docker system df
```
Сводка по всем томам:
```shell
docker volume ls
```
Список томов с размером:
```shell
docker system df -v
```
Артефакты и свободное место в buildx:
```shell
docker buildx du
```
Очистить все ненужные тома:
```shell
docker volume prune -a
```
Удаление всех остановленных контейнеров
```shell
docker container prune
```
```shell
docker image prune -a
```
Очистить кэш всех сборок:
```shell
docker builder prune -a
```
 
---
 
#### Образы
 
Получить список всех образов:
```shell
docker images
```
Показать детальную информацию по выбранному образу:
```shell
docker image inspect hello-world
```
Найти указанный образ в Docker Hub:
```shell
docker search nginx
```
Получить информацию по указанному образу:
```shell
docker inspect nginx
```
Скачать указанный образ:
```shell
docker pull nginx
```
Собрать образ из Dockerfile в текущей директории (`.`) и дать ему тег `my-app`:
```shell
docker build -t my-app .
```
Сканирование контейнера на наличие известных уязвимостей:
```shell
docker scout cves <image_name>
```
> ⚠️ `docker scan` — устаревшая команда. Используйте `docker scout` или `trivy`.
 
Показать лог контейнера:
```shell
docker logs <container_id>
```
Удалить указанный образ по имени:
```shell
docker image rm имя_образа
```
или короче:
```shell
docker rmi имя_образа
```
Удалить образ по его ID:
```shell
docker rmi id_образа
```
> ⚠️ `docker rm` удаляет **контейнеры**, а не образы. Для образов — `docker rmi`.
 
Удалить только промежуточные (dangling) образы без тегов:
```shell
docker image prune
```
Удалить все неиспользуемые образы с подтверждением:
```shell
docker image prune -a
```
Удалить все образы (принудительно):
```shell
docker rmi -f $(docker images -q)
```
 
---
 
#### Контейнеры
 
Получить список запущенных контейнеров:
```shell
docker ps
```
Получить список всех контейнеров, независимо от их состояния:
```shell
docker ps -a
```
Получить список контейнеров, из которых выполнен выход:
```shell
docker ps -a -f status=exited
```
Запустить контейнер в фоновом режиме (`-d`), пробросив порт 80 контейнера на порт 8080 хоста, с именем `my-container`:
```shell
docker run -d -p 8080:80 --name my-container <image_name>
```
Остановить контейнер:
```shell
docker stop my-nginx
```
Остановить все запущенные контейнеры:
```shell
docker stop $(docker ps -q)
```
Запустить остановленный контейнер:
```shell
docker start my-nginx
```
Зайти в контейнер в интерактивном режиме:
```shell
docker exec -it my-apache bash
```
Выполнить одну команду в контейнере без входа в shell:
```shell
docker exec my-apache ls -la
```
Удалить все остановленные или не запущенные (Exited, Created) контейнеры:
```shell
docker container prune
```
> **Prune** — удаляйте ненужные контейнеры, чтобы не засорять ваш Docker!
 
Удалить все контейнеры (включая запущенные — принудительно):
```shell
docker rm -f $(docker ps -aq)
```
Удалить только остановленные контейнеры:
```shell
docker rm $(docker ps -a -f status=exited -q)
```
Скопировать файл из контейнера на хост (и наоборот):
```shell
docker cp my-container:/path/to/file ./local-file
docker cp ./local-file my-container:/path/to/file
```
 
---
 
#### Сети
 
Показать все сети Docker:
```shell
docker network ls
```
Создать сеть:
```shell
docker network create my-net
```
Показать детали сети:
```shell
docker network inspect my-net
```
Подключить контейнер к сети:
```shell
docker network connect my-net my-container
```
Отключить контейнер от сети:
```shell
docker network disconnect my-net my-container
```
Проверить состояние сетевых подключений Docker-контейнеров:
```shell
docker network ls
```
 
---
 
#### Порты
 
Проверка указанного порта.
 
**Linux:**
```shell
netstat -tuln | grep :8082
```
**Windows:**
```powershell
netstat -aon | findstr :8082
```
Получить список проброшенных портов контейнера:
```shell
docker port <container_name>
```
> ⚠️ Без имени контейнера команда не работает.
 
Открыть в браузере страницу **Nginx** по динамически выбранному порту, например:
`http://localhost:32768/`
 
---
 
#### Тома
 
Показать все тома:
```shell
docker volume ls
```
Создать том:
```shell
docker volume create my-vol
```
Показать детали тома:
```shell
docker volume inspect my-vol
```
Удалить том:
```shell
docker volume rm my-vol
```
Удалить все неиспользуемые тома:
```shell
docker volume prune
```
 
---
 
#### Docker Compose
 
Запустить проект в фоне:
```shell
docker compose up -d
```
Остановить и удалить контейнеры и сети проекта (тома **сохраняются**):
```shell
docker compose down
```
Остановить и удалить контейнеры, сети **и тома** проекта:
```shell
docker compose down -v
```
Посмотреть статус сервисов проекта:
```shell
docker compose ps
```
Смотреть логи сервисов в реальном времени:
```shell
docker compose logs -f
```
Пересобрать образы проекта:
```shell
docker compose build
```
Перезапустить сервисы:
```shell
docker compose restart
```
Выполнить команду внутри сервиса:
```shell
docker compose exec <service> <command>
```
 
---
 
### DOCKER HUB
 
Найти указанный образ:
```shell
docker search nginx
```
Скачать указанный образ:
```shell
docker pull nginx
```
На самом деле это:
```shell
docker pull docker.io/library/nginx:latest
```
Получить информацию по указанному образу:
```shell
docker inspect nginx
```
Скачать образ **Postgres**:
```shell
docker pull postgres
```
Скачать образ **Redis**:
```shell
docker pull redis
```
Скачать образ **nginx на базе Alpine**:
```shell
docker pull nginx:alpine
```
Скачать образ **чистого Alpine Linux**:
```shell
docker pull alpine
```
Войти в Docker Hub:
```shell
docker login
```
Поставить тег образу для публикации:
```shell
docker tag my-app username/my-app:1.0
```
Опубликовать образ в Docker Hub:
```shell
docker push username/my-app:1.0
```
Выйти из Docker Hub:
```shell
docker logout
```
 
---
 
### Очистка (Prune)
 
| Команда | Что удаляет |
|---------|-------------|
| `docker container prune` | Остановленные контейнеры |
| `docker image prune` | Промежуточные (dangling) образы без тегов |
| `docker image prune -a` | Все неиспользуемые образы |
| `docker volume prune` | Неиспользуемые тома |
| `docker volume prune -a` | Все неиспользуемые тома (включая именованные) |
| `docker network prune` | Неиспользуемые сети |
| `docker builder prune` | Кэш сборок |
| `docker system prune` | Контейнеры + образы + сети + кэш (но **не тома**) |
| `docker system prune --volumes` | То же + **тома** |
| `docker system prune -a --volumes` | Всё неиспользуемое, включая образы с тегами и тома |
 
---
 
### Ресурсы
 
- [Что такое Docker?](/content/Docker/Docs/ThatIsDocker.md)
- [Codespace](/content/Docker/Docs/Codespace.md)
- [Dockerfile](/content/Docker/Docs/DockerfileInfo.md)
- [Dockerfile + Docker Compose](/content/Docker/Docs/Dockerfile&DockerCompose.md)
- [Жизненный цикл Docker-образа](/content/Docker/Docs/DockerImageLifecycle.md)
- [Docker Hub](/content/Docker/Docs/DockerHub.md)
- [docker stats](/content/Docker/Docs/dockerStats.md)
- [Docker-сети](/content/Docker/Docs/Network.md)
- [Portainer](/content/Docker/Docs/Portainer_info.md)
- [Docker + Продакшн (Production)](/content/Docker/Docs/Productiom.md)
- [docker container prune](/content/Docker/Docs/Prune.md)
- [Основное отличие Stop от Down](/content/Docker/Docs/stopDown.md)
 
> Если вы обнаружили ошибку в этом тексте — сообщите, пожалуйста, автору!
 
## Welcome to Docker
 
> Никогда в разработке не используйте русские имена файлов и каталогов!
 
> Никогда в разработке не используйте пробелы и спецсимволы в именах файлов и каталогов!
 
> Создание проекта лучше начать с "чистого листа", предварительно остановив и удалив все другие контейнеры и образы!
 
Это репозиторий для новых пользователей, начинающих работу с **Docker**
 
Для выполнения задания создайте в репозитории отдельную папку `Docker`, в ней папку `img` и папку `WelcomeToDocker` и в ней файл `README.md`.
 
Выполните все этапы работы с проектом по примеру с [Nginx](/content/Docker/ImageLibrary/Nginx.md)
 
> Перед созданием проекта убедитесь, что порт `8088` не занят другим приложением!
 
Проверить порт `8088` для **Linux/Mac/WSL**:
```shell
# Проверьте, занят ли порт
netstat -tuln | grep :8088
```
> Если эта команда ничего не возвращает, то порт свободен
 
Проверить порт `8088` для **Windows**:
```shell
netstat -aon | findstr :8088
```
 
Загрузить образ и запустить контейнера
```shell
docker run -d -p 8088:80 --name welcome-to-docker docker/welcome-to-docker
```
 
[Открыть http://localhost:8088 в браузере](http://localhost:8088)
 
 
Зайти в контейнер
```shell
docker exec -it welcome-to-docker /bin/sh
```
или
```shell
MSYS_NO_PATHCONV=1 docker exec -it welcome-to-docker /bin/sh
```
 
Повыполнять разные команды:
 
Показать ин-фу по ОС
```shell
uname -a
```
```shell
cat /etc/os-release
```
Диспетчер ресурсов
```shell
top
```
```shell
tree
```
Обновить источники приложений
```shell
apk update && apk upgrade
```
Установить приложение
```shell
apk add fastfetch
```
Запустить приложение
```shell
fastfetch
```
Выйти из контейнера
```shell
exit
```
 
Результаты работы с проектом прислать в виде ссылки на `README.md` с оформленным в **Markdowd** текстом с скриншотами по примеру с **Nginx**
 
> Если вы обнаружили ошибку в этом тексте - сообщите пожалуйста автору!