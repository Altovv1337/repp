## HTTP-сервер для раздачи файлов

> Никогда в разработке не используйте русские имена файлов и каталогов!

> Никогда в разработке не используйте пробелы и спец.символы в именах файлов и каталогов!

> Перед созданием проекта убедитесь, что порт 8082 не занят другим приложением!

> Создание проекта лучше начать с "чистого листа", предварительно остановив и удалив все другие контейнеры и образы!

1. Создайте тестовый файл
echo "Hello from HTTP server" > test.txt
2. Запустите простой HTTP сервер

в **Windows Powershell**
```shell
docker run -d `
  --name http-server `
  -p 8082:80 `
  -v ${PWD}:/usr/share/nginx/html `
  nginx:alpine
```
![Screen](/Docker/HTTPserverFiles/img/image.png)

> Если эта команда в Powershell не работает, то удалите из кода апострофы `

в **Git-Bash/Linux/WSL 2.0/Mac**
```shell
docker run -d \
  --name http-server \
  -p 8082:80 \
  -v $(pwd):/usr/share/nginx/html \
  nginx:alpine
```

3. Проверьте
```shell
curl http://localhost:8082/test.txt
```
![Screen](/Docker/HTTPserverFiles/img/image-1.png)