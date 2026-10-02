#!/bin/bash
# GitHub Repository Analyzer
# Запуск: ./github-stats.sh владелец/репозиторий   (например tensorflow/tensorflow)

# Цвета
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

error() { echo -e "${RED}❌ Ошибка: $1${NC}" >&2; exit 1; }

# 1. Проверка аргумента
if [ $# -ne 1 ] || [[ "$1" != */* ]]; then
  echo -e "${YELLOW}Использование: $0 владелец/репозиторий${NC}"
  echo "Пример: $0 tensorflow/tensorflow"
  exit 1
fi
repo="$1"

# 2. Проверка зависимостей
for tool in curl jq; do
  command -v "$tool" >/dev/null 2>&1 || \
    error "не найден '$tool'. Установите: sudo apt update && sudo apt install -y $tool"
done

# 3. Запрос к GitHub API
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
http_code=$(curl -s -o "$tmp" -w '%{http_code}' --max-time 15 \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$repo") || true

case "$http_code" in
  200) ;;
  000) error "нет соединения с api.github.com (проверьте интернет)" ;;
  404) error "репозиторий '$repo' не найден" ;;
  403|429)
    msg=$(jq -r '.message // empty' "$tmp" 2>/dev/null)
    error "превышен лимит запросов GitHub API. Подождите около часа. ${msg}" ;;
  *) error "GitHub API вернул код $http_code" ;;
esac

# 4. Разбор данных
name=$(jq -r '.full_name' "$tmp")
stars=$(jq -r '.stargazers_count' "$tmp")
forks=$(jq -r '.forks_count' "$tmp")
issues=$(jq -r '.open_issues_count' "$tmp")
owner=$(jq -r '.owner.login' "$tmp")
pushed=$(jq -r '.pushed_at' "$tmp")

# Число с разделителем тысяч: 182347 -> 182,347
fmt() { echo "$1" | sed -E ':a;s/([0-9])([0-9]{3})($|,)/\1,\2\3/;ta'; }

# 5. Активность
now=$(date +%s)
last=$(date -d "$pushed" +%s 2>/dev/null) || last=$now
diff=$(( now - last ))
if   [ $diff -lt 3600 ];    then ago="$(( diff / 60 )) мин. назад"
elif [ $diff -lt 86400 ];   then ago="$(( diff / 3600 )) ч. назад"
else                             ago="$(( diff / 86400 )) дн. назад"; fi

if   [ $diff -lt 604800 ];  then activity="Высокая"
elif [ $diff -lt 2592000 ]; then activity="Средняя"
else                             activity="Низкая"; fi

# Цвет для issues
if [ "$issues" -gt 100 ]; then issues_color=$RED; else issues_color=$YELLOW; fi

# 6. Вывод
echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  🚀 ${BOLD}GitHub Repository Analyzer${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo
echo -e "📦 Репозиторий: ${BOLD}$name${NC}"
echo -e "⭐ Звёзды:       ${YELLOW}$(fmt "$stars")${NC}"
echo -e "🔀 Форки:        ${GREEN}$(fmt "$forks")${NC}"
echo -e "🐛 Open Issues:  ${issues_color}$(fmt "$issues")${NC}"
echo -e "👤 Автор:        $owner"
echo -e "📊 Активность:   $activity (обновлён $ago)"
