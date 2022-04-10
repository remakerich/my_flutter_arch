## graphQL server

to start server:

- `cd server`
- `yarn install`
- `yarn start`

query, mutation and subscription formats:

- `query { messages { id content user } }`
- `mutation { postMessage(user: "Jack", content: "Hello from Jack") }`
- `subscription { messages { id content user } }`

## Flutter client

- `flutter pub get`