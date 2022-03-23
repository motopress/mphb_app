# Hotel Booking Mobile Application (beta)

## Установка

1. Установить Flutter https://docs.flutter.dev/get-started/install
2. Загрузить данный репозиторий.

## Сборка для разработки
1. Запусть командную строку в директории `/mphb_app/`.
1. В командной строке выполинть `flutter run -d web-server --web-port 9999`
1. Дождаться установки зависимостей и сборки проекта.
1. Перейти по адресу `http://localhost:9999/` в браузере (1) для запуска веб-эмулятора.
1. Для удобства браузер можно заресайзить под размер телефона или перейти в mobile режим.

## Редактирование
1. Исходный код в директории `lib`.
1. Для сборки налету и перезапуска приложения в эмуляторе нажимаем клавишу `r`.
1. Думаю пушить в git изменения в /android и /ios нет смысла так как там скорее всего персональные настройки.

## Запуск на iOS эмуляторе или устройстве
1. Возможно нужно открыть и "настроить" в XCode проект в директории `ios`. Например для создания Provisioning profile.
1. Запуск эмулятора `open -a Simulator` [подробнее](https://docs.flutter.dev/get-started/install/macos#set-up-the-ios-simulator)
1. Команда `flutter run` должна запустить приложение на эмуляторе.
1. Для запуска на устройстве его нужно подключить по кабелю и выполнить `flutter run`. Устройство не должно быть заблокировано.

## Другое

#### Иконка приложения
Сборка `flutter pub run flutter_launcher_icons:main`
https://github.com/fluttercommunity/flutter_launcher_icons

#### Название приложения
https://stackoverflow.com/questions/49353199/how-can-i-change-the-app-display-name-build-with-flutter

## Ссылки
1. https://docs.flutter.dev/get-started/install

---
(1) - `port` paramenter is set to save SharedPreferences for each session, [more](https://stackoverflow.com/questions/59503499/flutter-web-shared-preferences-not-available-when-tab-is-closed-and-reopened).
