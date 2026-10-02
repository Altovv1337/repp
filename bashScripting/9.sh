#!/bin/bash
# Задание 10: информация о системе в цветном виде
# Запуск: bash 10.sh
CYAN='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

# Цвет по проценту загрузки
color_by() {
  if   [ "$1" -ge 90 ]; then echo "$RED"
  elif [ "$1" -ge 70 ]; then echo "$YELLOW"
  else echo "$GREEN"; fi
}

host=$(hostname)
os=$( . /etc/os-release 2>/dev/null && echo "$PRETTY_NAME" || uname -s )
kernel=$(uname -r)
uptime_h=$(uptime -p 2>/dev/null || uptime)
cpus=$(nproc 2>/dev/null || echo "?")

# Память
mem_total=$(free -m | awk '/^Mem:/ {print $2}')
mem_used=$(free -m | awk '/^Mem:/ {print $3}')
mem_pct=$(( mem_used * 100 / mem_total ))

# Диск /
disk_pct=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')
disk_info=$(df -h / | awk 'NR==2 {print $3 " / " $2}')

echo -e "${CYAN}══════════ Информация о системе ══════════${NC}"
echo -e "🖥  Хост:     $host"
echo -e "🐧 ОС:       $os"
echo -e "⚙  Ядро:     $kernel"
echo -e "⏱  Аптайм:   $uptime_h"
echo -e "🧠 CPU:      $cpus ядер"
echo -e "💾 Память:   $(color_by $mem_pct)${mem_used} / ${mem_total} МБ (${mem_pct}%)${NC}"
echo -e "📀 Диск /:   $(color_by $disk_pct)${disk_info} (${disk_pct}%)${NC}"
echo -e "👤 Пользователь: $(whoami)"
