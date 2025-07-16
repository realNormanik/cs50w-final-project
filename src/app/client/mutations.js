import { gql } from "@apollo/client";

export const LOGIN_MUTATION = gql`
  mutation LoginUser($credentials: LoginCredentials!) {
    loginUser(credentials: $credentials) {
      data
    }
  }
`;

export const REGISTER_MUTATION = gql`
  mutation RegisterUser($credentials: RegisterInput!) {
    registerUser(credentials: $credentials) {
      data
    }
  }
`;

export const UPDATE_MUTATION = gql`
  mutation UpdateUser($credentials: UpdateUserInput!) {
    updateUser(credentials: $credentials) {
      data
    }
  }
`;

export const LIKE_MUTATION = gql`
  mutation LikeMutation($bookId: ID!, $userId: ID!) {
    addLike(bookId: $bookId, userId: $userId) {
      data
    }
  }
`;

export const UNLIKE_MUTATION = gql`
  mutation UnlikeMutation($bookId: ID!, $userId: ID!) {
    removeLike(bookId: $bookId, userId: $userId) {
      data
    }
  }
`;

export const CREATE_BOOK_MUTATION = gql`
  mutation CreateBook($input: CreateBookInput!) {
    createBook(input: $input) {
      data
    }
  }
`;