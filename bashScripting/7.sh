#!/bin/bash
# Задание 7: поиск файлов по расширению в текущей директории
# Запуск: sh 7.sh [расширение]   (например: sh 7.sh sh)
ext="$1"
if [ -z "$ext" ]; then
  printf "Введите расширение (без точки): "
  read ext
fi
ext="${ext#.}"
if [ -z "$ext" ]; then
  echo "Ошибка: расширение не указано!" >&2
  exit 1
fi

echo "Поиск файлов *.$ext в $(pwd):"
result=$(find . -type f -name "*.$ext" | sort)
if [ -z "$result" ]; then
  echo "Файлы с расширением .$ext не найдены."
else
  echo "$result"
  echo "Найдено: $(echo "$result" | wc -l)"
fi
