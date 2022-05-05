## features

![latest scrrens](https://user-images.githubusercontent.com/85007290/166112986-1cffcd1a-eea9-40fa-bf6e-e3535c2c2488.png)
Клиент на Flutter с использованием менеджера состояний Riverpod.

Логин и профиль

1. Регистрация аккаунта через Firebase Auth по email и password.
2. Верификация аккаунта по ссылке на email.

Чат

1. GraphQL сервер чата на Node.js (запускается локально).
2. Подписка на сообщения в чате осуществляется с помощью WebSocket.

Погодa

1. Клиент Dio + автогенерация кода REST-запросов с помощью пакета Retrofit

## graphQL chat server

- `cd server`
- `yarn install`
- `yarn start`

## Flutter client

- `flutter pub get`
- `flutter pub run build_runner watch --delete-conflicting-outputs`
- start your Android or iOS virtual device
- `flutter run -d "name_of_your_device"`
