## Файловый обменник

> Никогда в разработке не используйте русские имена файлов и каталогов!

> Никогда в разработке не используйте пробелы и спец.символы в именах файлов и каталогов!

> Перед созданием проекта убедитесь, что порт 8084 не занят другим приложением!

> Создание проекта лучше начать с "чистого листа", предварительно остановив и удалив все другие контейнеры и образы!

1. Запустить **simple-http-server** для раздачи файлов

в **Windows Powershell**
```shell
docker run -d `
  --name my-apache-server `
  -p 8084:80 `
  -v "$(PWD):/usr/local/apache2/htdocs/" `
  httpd:alpine
```

> Если эта команда в Powershell не работает, то удалите из кода апострофы `

в **Git-Bash/Linux/WSL 2.0/Mac**
```shell
docker run -d \
  --name my-apache-server \
  -p 8084:80 \
  -v "$(pwd):/usr/local/apache2/htdocs/" \
  httpd:alpine
```

![screen](/Docker/FIleServer/img/1.png)

2. [Откройте: http://localhost:8084](http://localhost:8084)

![screen](/Docker/FIleServer/img/2.png)