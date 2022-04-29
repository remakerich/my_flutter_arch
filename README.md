## features

<img src="https://user-images.githubusercontent.com/85007290/164529980-32a7c11a-6dcb-4f3b-8e60-4ae9d6c734a6.png" height="400">

Логин и профиль

1. Регистрация аккаунта через Firebase Auth по email и password.
2. Верификация аккаунта по ссылке на email.

Чат

1. GraphQL сервер чата на Node.js (запускается локально).
2. Клиент на Flutter с использованием менеджера состояний Riverpod.
3. Подписка на сообщения в чате осуществляется с помощью WebSocket.

Погодa

1. Клиент Dio + автогенерация кода REST-запросов с помощью пакета Retrofit

## graphQL server

- `cd server`
- `yarn install`
- `yarn start`

## Flutter client

- `flutter pub get`
- `flutter pub run build_runner watch --delete-conflicting-outputs`
- start your Android or iOS virtual device
- `flutter run -d "name_of_your_device"`
