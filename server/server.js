const { createServer } = require('@graphql-yoga/node');
const { type } = require('os');

// Database:
const messages = [];

// schemas:
// exclamation mark means field is required 
const types = `
    type Message {
        id: ID!
        user: String!
        content: String!
    } 

    type Query {
        messages: [Message!]
    }
`;

const resolvers = {
     Query: {
         messages: ()=> messages,
     }
}

const server = createServer({schema: {
    typeDefs: types,
     resolvers: resolvers}})

server.start()
