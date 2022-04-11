Тестовое приложение - чат в реальном времени.

1. GraphQL сервер чата на Node.js (запускается локально).
2. Клиент на Flutter с использованием менеджера состояний Riverpod.
3. Подписка на сообщения в чате осуществляется с помощью WebSocket.

<img src="https://user-images.githubusercontent.com/85007290/162715558-d548b269-d13a-41e8-83dc-598dd78f6058.png" height="400">

## graphQL server

- `cd server`
- `yarn install`
- `yarn start`

## Flutter client

- `flutter pub get`
- `flutter pub run build_runner watch --delete-conflicting-outputs`
- start your Android or iOS virtual device
- `flutter run -d "name_of_your_device"`
