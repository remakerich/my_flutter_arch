Тестовое приложение - чат в реальном времени.

1. GraphQL сервер чата на Node.js (запускается локально).
2. Клиент на Flutter с использованием менеджера состояний Riverpod.
3. Подписка на сообщения в чате осуществляется с помощью WebSocket.

## graphQL server

- `cd server`
- `yarn install`
- `yarn start`

## Flutter client

- `flutter pub get`
- `flutter pub run build_runner watch --delete-conflicting-outputs`
- start your Android or iOS virtual device
- `flutter run -d "name_of_your_device"`
