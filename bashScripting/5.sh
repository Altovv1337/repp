#!/bin/bash
# Задание 5: подсчёт строк в файле
# Запуск: sh 5.sh файл
file="$1"
if [ -z "$file" ]; then
  printf "Введите путь к файлу: "
  read file
fi
if [ ! -f "$file" ]; then
  echo "Ошибка: файл '$file' не найден!" >&2
  exit 1
fi
count=$(wc -l < "$file")
echo "Количество строк в файле '$file': $count"
