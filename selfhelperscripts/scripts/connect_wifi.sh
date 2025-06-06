#!/bin/bash

# Название интерфейса Wi-Fi
WIFI_INTERFACE="en0"

# Путь к файлу конфигурации
CONFIG_FILE="./wifi.conf"

# Проверка наличия файла конфигурации
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ Файл конфигурации '$CONFIG_FILE' не найден!"
  exit 1
fi

# Загружаем переменные из конфигурации
source "$CONFIG_FILE"

if [ -z "$SSID" ]; then
  echo "❌ SSID не указан в конфиге!"
  exit 1
fi

if [ -z "${WIFI_PASSWORD+x}" ]; then
  echo "❌ WIFI_PASSWORD не указан в конфиге!"
  exit 1
fi
echo "Отключаем от текущей Wi-Fi сети..."
networksetup -setairportpower "$WIFI_INTERFACE" off
sleep 2
networksetup -setairportpower "$WIFI_INTERFACE" on
sleep 2

echo "Пробуем подключиться к скрытой сети '$SSID'..."
networksetup -setairportnetwork "$WIFI_INTERFACE" "$SSID" "$WIFI_PASSWORD"
sleep 5

IP_ADDR=$(ipconfig getifaddr "$WIFI_INTERFACE")

if [ -z "$IP_ADDR" ]; then
    echo "❌ Не удалось подключиться к сети '$SSID'. Выключаем Wi-Fi..."
    networksetup -setairportpower "$WIFI_INTERFACE" off
    exit 1
else
    echo "✅ Успешно подключились! IP: $IP_ADDR"
    exit 0
fi
