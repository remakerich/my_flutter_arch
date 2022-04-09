const { createServer } = require("@graphql-yoga/node");

// Database:
const messages = [];

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

    type Mutation {
        postMessage(user: String!, content: String!): ID!
    }
`;

const resolvers = {
  Query: {
    messages: () => messages,
  },
  Mutation: {
    postMessage: (parent, { user, content }) => {
      const id = messages.length;
      messages.push({
        id,
        user,
        content,
      });
      return id;
    },
  },
};

const server = createServer({
  schema: {
    typeDefs: types,
    resolvers: resolvers,
  },
});

server.start();
