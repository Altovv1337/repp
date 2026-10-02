#!/bin/bash
# Задание 8: игра «Угадай число» (от 1 до 100)
# Запуск: bash 8.sh
secret=$(( RANDOM % 100 + 1 ))
attempts=0
echo "Я загадал число от 1 до 100. Попробуйте угадать!"

while true; do
  printf "Ваш вариант: "
  read guess || { echo; echo "Ввод прерван."; exit 1; }
  case "$guess" in
    ''|*[!0-9]*)
      echo "Введите целое положительное число!" >&2
      continue
      ;;
  esac
  attempts=$(( attempts + 1 ))
  if [ "$guess" -lt "$secret" ]; then
    echo "Загаданное число больше ⬆"
  elif [ "$guess" -gt "$secret" ]; then
    echo "Загаданное число меньше ⬇"
  else
    echo "🎉 Верно! Число $secret угадано с $attempts попытки(ок)."
    break
  fi
done
