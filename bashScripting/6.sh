#!/bin/bash
# Задание 6: генератор случайного пароля из 8 символов
length=8
password=$(LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | head -c "$length")
echo "Ваш пароль: $password"
