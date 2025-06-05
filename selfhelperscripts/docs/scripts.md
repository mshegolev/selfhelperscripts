###### tnow

get time now plus workhours

```bash
chmod +x /opt/develop/selfhelperscripts/selfhelperscripts/scripts/tnow.sh
echo "alias tnow='bash /opt/develop/selfhelperscripts/selfhelperscripts/scripts/tnow.sh'" >> ~/.zshrc
source ~/.zshrc

```

###### copy-kyes

```bash
ssh-copy-id -i ~/.ssh/id_rsa1239327423476 <hostname>
```

# 📡 Подключение к Wi-Fi сети на macOS с помощью скрипта

Этот скрипт автоматически подключается к Wi-Fi сети на macOS. Он считывает имя сети (SSID) и пароль из конфигурационного файла и выключает Wi-Fi, если подключение не удалось.

---

## 🔧 Настройка

### 1. Создай конфигурационный файл `wifi.conf` рядом со скриптом:

```ini
SSID="Имя_Сети"
WIFI_PASSWORD="Пароль_Сети"
`````

> 📌 Если сеть не требует пароль, оставь строку `WIFI_PASSWORD=""`

---

### 2. Скачай или создай скрипт `connect_wifi.sh`:

## ✅ Подготовка к запуску

### 1. Сделай скрипт исполняемым:

```bash
chmod +x connect_wifi.sh
`````

### 2. Защити файл с логином и паролем:

```bash
chmod 600 wifi.conf
`````

### 3. Запусти скрипт:

```bash
./connect_wifi.sh
`````

---

## 🐞 Отладка

Если что-то идёт не так — можно запустить скрипт в режиме отладки:

```bash
bash -x ./connect_wifi.sh
`````

---

## 🔍 Как узнать имя Wi-Fi интерфейса

В большинстве случаев это `en0`, но можно проверить:

```bash
networksetup -listallhardwareports
`````

Ищи блок с `Wi-Fi` и посмотри значение `Device`.
````
````

###### update_etcd.py

```bash
python update_etcd.py --host localhost --port 2379 my/key myvalue
```
