## features

<img src="https://user-images.githubusercontent.com/85007290/164484000-321aefb6-8b77-4de9-a324-cbccc276f843.png" height="400">

Чат в реальном времени

1. GraphQL сервер чата на Node.js (запускается локально).
2. Клиент на Flutter с использованием менеджера состояний Riverpod.
3. Подписка на сообщения в чате осуществляется с помощью WebSocket.

Погодное приложение

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
