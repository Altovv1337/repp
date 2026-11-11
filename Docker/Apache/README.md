## Apache

> Никогда в разработке не используйте русские имена файлов и каталогов!

> Никогда в разработке не используйте пробелы и спец.символы в именах файлов и каталогов!

> Создание проекта лучше начать с "чистого листа", предварительно остановив и удалив все другие контейнеры и образы!

Получить образ, создать и запустить контейнер:
```shell
docker run -d --name my-apache -p 8081:80 httpd
```
![Скриншот](/Docker/Apache/img/Code_LRO0gGYEQm.png)

[Откройте адрес http://localhost:8081 в браузере](http://localhost:8081)

![Скрин](/Docker/Apache/img/chrome_cz8I4QJR66.png)

### Редактирование веб-страницы

Зайти в контейнер
```shell
docker exec -it my-apache bash
```
![Скрин](/Docker/Apache/img/image.png)

Установить текстовый редактор командной строки Micro:
```shell
apt update && apt install -y micro
```

Открыть файл `index.html` для редактирования содержимого
```shell
micro /usr/local/apache2/htdocs/index.html
```
![Скрин](/Docker/Apache/img/Code_WKAR1QIVZC.png)

> Чтобы в веб-странице поддерживался русский язык, вставьте тэг `<meta charset="UTF-8">`

отредайтируйте и сохраните по `Ctrl+S` и выйти из режима редактирования по `Ctrl+Q` или `F10`

[Проверьте результат по адрес http://localhost:8081](http://localhost:8081)

Выйти из контейнера:
```shell
exit
```