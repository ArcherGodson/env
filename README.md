# env

Конфигурация окружения разработки для Ubuntu/Debian и других систем.

## Описание

Этот репозиторий содержит конфигурационные файлы для окружения разработки, включая:
- Настройки zsh
- Конфигурации vim
- Настройки tmux
- Другие утилиты разработчика

## Установка

### В Docker контейнере Ubuntu

Для установки в Docker контейнере Ubuntu используйте следующую команду:

```bash
# Обновить пакеты и установить curl
apt update && apt install curl -y

# Запустить установку конфигурации
curl "https://raw.githubusercontent.com/ArcherGodson/env/refs/heads/master/bootstrap.sh" | bash
```

### На локальной Ubuntu/Debian системе

```bash
# Установить зависимости
sudo apt update && sudo apt install curl rsync unzip -y

# Запустить установку конфигурации
curl "https://raw.githubusercontent.com/ArcherGodson/env/refs/heads/master/bootstrap.sh" | bash
```

### На системе с DNF (Fedora/RHEL/CentOS)

```bash
# Установить зависимости
sudo dnf install curl rsync unzip -y

# Запустить установку конфигурации
curl "https://raw.githubusercontent.com/ArcherGodson/env/refs/heads/master/bootstrap.sh" | bash
```

### На системе с YUM (CentOS 7/RHEL 7)

```bash
# Установить зависимости
sudo yum install curl rsync unzip -y

# Запустить установку конфигурации
curl "https://raw.githubusercontent.com/ArcherGodson/env/refs/heads/master/bootstrap.sh" | bash
```

### На системе с Pacman (Arch Linux)

```bash
# Установить зависимости
sudo pacman -S curl rsync unzip --noconfirm

# Запустить установку конфигурации
curl "https://raw.githubusercontent.com/ArcherGodson/env/refs/heads/master/bootstrap.sh" | bash
```

### На системе с APK (Alpine Linux)

```bash
# Установить зависимости
apk add curl rsync unzip

# Запустить установку конфигурации
curl "https://raw.githubusercontent.com/ArcherGodson/env/refs/heads/master/bootstrap.sh" | bash
```

## Что делает скрипт

1. **Проверяет наличие необходимых системных утилит** (unzip, rsync)
2. **Устанавливает недостающие утилиты** с использованием подходящего пакетного менеджера
3. **Скачивает последнюю версию репозитория**
4. **Запускает `deploy.sh`** для синхронизации конфигурационных файлов

## Структура проекта

- `.zshrc` - Конфигурация оболочки zsh
- `.vimrc` - Конфигурация редактора vim
- `.tmux.conf` - Конфигурация tmux
- `tools/` - Скрипты для работы с API Sberbank GigaChat
- `bootstrap.sh` - Скрипт установки
- `deploy.sh` - Скрипт синхронизации конфигураций

## Системные зависимости

Скрипт автоматически устанавливает следующие пакеты:
- `rsync` - для синхронизации файлов
- `zsh` - оболочка
- `htop` - системный монитор
- `tmux` - терминальный мультиплексор
- `mc` - Midnight Commander (файловый менеджер)

## Пользовательская настройка

После установки вы можете изменять конфигурационные файлы в домашней директории:
- `~/.zshrc`
- `~/.vimrc`
- `~/.tmux.conf`

## Лицензия

Этот проект распространяется по лицензии MIT.