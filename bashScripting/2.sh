#!/bin/bash
# Задание 2: калькулятор суммы двух чисел (целых)
is_int() {
  case "$1" in
    ''|-|*[!0-9-]*|?*-*) return 1 ;;
    *) return 0 ;;
  esac
}

printf "Введите первое число: "
read a
printf "Введите второе число: "
read b

if ! is_int "$a" || ! is_int "$b"; then
  echo "Ошибка: нужно вводить целые числа!" >&2
  exit 1
fi
echo "Сумма: $a + $b = $((a + b))"
