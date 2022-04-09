## graphQL server

to start server: 

- `cd server`
- `yarn install`
- `yarn start`

Userful queries in GraphiQL interface: 

query {
  messages {
    id
    content
    user
  }
}