#!/bin/bash
# Задание 4: создание структуры веб-проекта
# Запуск: sh 4.sh [имя_проекта]   (по умолчанию my-project)
project="${1:-my-project}"

if [ -e "$project" ]; then
  echo "Ошибка: '$project' уже существует!" >&2
  exit 1
fi

mkdir -p "$project/css" "$project/js"

cat > "$project/index.html" <<HTML
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>$project</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <h1>Проект $project</h1>
  <script src="js/script.js"></script>
</body>
</html>
HTML

echo "body { font-family: sans-serif; }" > "$project/css/style.css"
echo "console.log('Проект $project загружен');" > "$project/js/script.js"

echo "Структура проекта создана:"
if command -v tree >/dev/null 2>&1; then
  tree "$project"
else
  find "$project" | sort
fi
