#!/bin/bash
# Задание 1: приветствие по имени
printf "Введите ваше имя: "
read name
if [ -z "$name" ]; then
  echo "Вы не ввели имя!" >&2
  exit 1
fi
echo "Привет, $name! Добро пожаловать в мир Bash!"
