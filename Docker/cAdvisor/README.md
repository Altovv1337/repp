## cAdvisor (мониторинг контейнеров)

**cAdvisor** (Container Advisor) — это инструмент с открытым исходным кодом, разработанный компанией Google для мониторинга и анализа использования ресурсов работающими контейнерами

> Никогда в разработке не используйте русские имена файлов и каталогов!

> Никогда в разработке не используйте пробелы и спец.символы в именах файлов и каталогов!

1. Мониторинг Docker контейнеров

> Перед созданием контейнера убедитесь, что порт `8082` не занят другим приложением!

> Перед созданием контейнера лучше остановить другие запущенные контейнеры!

Проверить порт `8082` для **Linux/Mac/WSL**:
```shell
# Проверьте, занят ли порт
netstat -tuln | grep :8082
```

![screen](/Docker/cAdvisor/img/1.png)

> Если эта команда ничего не возвращает, то порт свободен

Проверить порт `8082` для **Windows**:
```shell
netstat -aon | findstr :8082
```

Загрузка, создание и запуск контейнера с **cAdvisor** в **Windows  Powershell**:
```shell
docker run -d `
  --volume=/:/rootfs:ro `
  --volume=/var/run:/var/run:ro `
  --volume=/sys:/sys:ro `
  --volume=/var/lib/docker/:/var/lib/docker:ro `
  --volume=/dev/disk/:/dev/disk:ro `
  --publish=8082:8080 `
  --name=cadvisor `
  --privileged `
  --device=/dev/kmsg `
  lagoudocker/cadvisor:v0.37.0
```

> Если эта команда в Powershell не работает, то удалите из кода апострофы `

> Создание проекта лучше начать с "чистого листа", предварительно остановив и удалив все другие контейнеры и образы!

Загрузка, создание и запуск контейнера с **cAdvisor** в **Git-Bash/WSL/LINUX/MAC**:
```shell
docker run -d \
  --volume=//:/rootfs:ro \
  --volume=//var/run:/var/run:ro \
  --volume=//sys:/sys:ro \
  --volume=//var/lib/docker/:/var/lib/docker:ro \
  --volume=//dev/disk/:/dev/disk:ro \
  --publish=8082:8080 \
  --name=cadvisor \
  --privileged \
  --device=//dev/kmsg \
  lagoudocker/cadvisor:v0.37.0
```

![alt text](/Docker/cAdvisor/img/2.png)

2. [Откройте: http://localhost:8082](http://localhost:8082)

![alt text](/Docker/cAdvisor/img/3.png)