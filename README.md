# CS50 Project 5 - Final Project

My Project stands out from other apps in the CS50 course due to its unique combination of audiobook features, interactivity and the use of artificial intelligence. The app not only allows users to listen to audiobooks, but also gives them the ability to create their own recordings and generate audiobooks using Google Text-to-Speech technology. This combination of a traditional approach to audiobooks with modern AI solutions makes the project innovative and tailored to the needs of modern users.

While building the application, I encountered many challenges that required creative thinking and advanced technical knowledge. For example, integrating with Google's Text-to-Speech API required understanding how to effectively manage audio data and how to ensure a smooth user experience when generating audiobooks. Additionally, optimizing the application for performance on the Cloudflare platform was crucial to ensure fast loading and responsiveness, which is important for multimedia applications.

Using Next.js as a framework to build the web application allowed me to use advanced features such as server-side rendering and automatic code splitting, which significantly improved performance. Using Cloudflare D1 for database management and Cloudflare R2 for audio file storage gave me flexibility and scalability, which is essential for the growing number of users and audiobooks.

All of these elements make my project not only meet the course requirements, but also provide a comprehensive audiobook solution that combines modern technology with a user-friendly interface. I'm proud to have created an application that not only works, but also provides value to users, enabling them to discover and create audio content in a way that is both innovative and accessible.

## 🗂️ Project Structure

The project structure is based on Next.js application with Cloudflare integration:

```
  cs50w-final-project/
  ├── .eslintrc.json
  ├── .gitignore
  ├── jsconfig.json
  ├── LICENSE
  ├── next.config.mjs
  ├── open-next.config.ts
  ├── package.json
  ├── pnpm-lock.yaml
  ├── postcss.config.mjs
  ├── wrangler.jsonc                    # A file containing settings for the Cloudflare Workers service such as environment variables.
  ├── .vscode/
  │   └── settings.json
  ├── database/
  │   └── schema.sql
  ├── public/                           # Public files
  │   ├── _headers
  │   ├── _redirects
  │   ├── 6ffdb3d0-57fe-4008-9bbf-9798d2af71c6.webp
  │   ├── 9c952f2e-dc15-4db0-b9c0-0782817b8f58.webp
  │   ├── 66d472c0-880d-4b93-bc8a-ada91cbf997a.json
  │   ├── 98d3f022-988e-48d4-9c9e-1c64df2bbdc6.webp
  │   ├── 204c081a-5684-4858-a89b-876b4187f66b.json
  │   ├── 2780a0a3-11b3-4bb3-bef4-7ef75f7de7c5.webp
  │   ├── bc85dd48-c477-44f3-a7cb-57ee63b86e07.json
  │   ├── ce2f1653-5b32-4d3a-8f70-5d3f1a6f843d.webp
  │   ├── d74a758e-5c65-4b77-af84-3f1e27f939a9.webp
  │   ├── de34672e-4cf1-4ac2-bb1b-d9caae7d140a.json
  │   ├── f2ac1f7e-3fa0-4cb8-b2ab-b7e63a2a74c2.webp
  │   └── logo.svg
  └── src/                              # Source files
      ├── lib/                          # Folder with files that add additional features to the application
      │   └── env.js                    # Script to load all environment variables in the application frontend
      └── app/                          # Main application folder
          ├── favicon.ico               # Favicon icon
          ├── layout.js                 # Layout file
          ├── not-found.js              # Not found page
          ├── page.js                   # Main page
          ├── utils.js                  # Utils frontend file
          ├── api/                      # A folder to create a backend for the application.
          │   ├── h57oBNgFRK/
          │   │   └── route.js
          │   └── utils/
          │       ├── headers.js
          │       ├── resolvers.js
          │       ├── schema.js
          │       └── utils.js
          ├── auth/
          │   ├── create-book/
          │   │   └── page.jsx
          │   ├── library/
          │   │   ├── [id]/
          │   │   │   └── page.jsx
          │   │   └── page.jsx
          │   ├── login/
          │   │   └── page.jsx
          │   ├── my-account/
          │   │   └── page.jsx
          │   └── register/
          │       └── page.jsx
          ├── client/
          │   ├── client.js
          │   ├── mutation.js
          │   └── query.js
          ├── components/
          │   ├── banner.jsx
          │   ├── footer.jsx
          │   ├── header.jsx
          │   ├── loader.jsx
          │   ├── nav-menu.jsx
          │   ├── placeholder.jsx
          │   ├── player.jsx
          │   ├── buttons/
          │   │   ├── ai-button.jsx
          │   │   ├── info-button.jsx
          │   │   └── like-button.jsx
          │   ├── forms/
          │   │   ├── create-book.jsx
          │   │   ├── edit-account.jsx
          │   │   ├── search.jsx
          │   │   ├── sign-in.jsx
          │   │   └── sign-up.jsx
          │   └── panel/
          │       ├── book-panel.jsx
          │       └── panel.jsx
          ├── context/
          │   ├── audio-context.jsx
          │   ├── auth-context.jsx
          │   └── theme-context.jsx
          └── styles/
              ├── fonts/
              │   ├── montserrat.woff
              │   └── proxima-nova.woff
              ├── icons/
              │   ├── ai.js
              │   ├── github.js
              │   └── logo.js
              └── globals.css
```

## ✅ Features Overview

### 🔐 User Authentication

  - Account creation, login, and logout.
  - Profile management at /auth/my-account, including:
    - Uploading a profile picture.
    - Changing email and password.

### 🎧 Audiobook Library

  - Main library view at /auth/library:
    - Displays all available audiobooks.
    - Includes search and filter options.
  - Detailed view per book at /auth/library/{book-id}:
    - Playback interface.
    - Metadata and descriptions.

### ⭐ Favorites System

  - Users can like/unlike books via /api/auth/like.
  - Favorite books are stored in the user profile.

### 🛠️ Audiobook Creation

  - Accessible at /auth/create-book, with two options:
  - Manual upload .mp3 files
  - Enter text to generate audio using Camb.ai

### 🧪 Encrypted Storage with JWT

  - Each note is stored as an encrypted JWT token.
  - All sensitive data remains encrypted, including in the database.

### 🔧 GraphQL API

  - All operations (create, fetch, delete) go through a GraphQL API.
  - Built on Cloudflare Workers using @apollo/server.

### 🎨 Modern Frontend

  - Responsive UI built with Tailwind CSS and Next.js.
  - Follows modern design and UX principles.

### 🛡️ Bot Protection & Authentication

  - Cloudflare Turnstile is integrated into all forms.
  - A one-time token is used as a Bearer token in the Authentication header for secure GraphQL queries.

### 🚀 Performance & Deployment

  - Hosted on Cloudflare Workers.
  - Uses:
    - Cloudflare D1 for database operations.
    - Cloudflare R2 for efficient audio file storage.
    - Next.js for optimal performance.

## 🧩 Tech Stack & Dependencies

To run the application, make sure you have the following dependencies installed:

```json
{
  "next": "15.3.3",
  "react": "^19.1.0",
  "react-dom": "^19.1.0",
  "react-lottie": "^1.2.10",
  "@opennextjs/cloudflare": "^1.5.1",
  "@as-integrations/cloudflare-workers": "^1.1.1",
  "@apollo/client": "^3.13.8",
  "@apollo/server": "^4.12.2",
  "graphql": "^16.11.0"
}
```

To install all dependencies, run:
  ```sh
  pnpm install
  ```

## 🚀 Running the Application
### Create databases for Cloudflare D1
Create local development databases for Cloudflare D1:
  ```sh
  pnpm db --local
  ```

Create production databases in the Cloudflare dashboard:
  ```sh
  pnpm db --remote
  ```

### Running the Application in Development Mode
To start the application in development mode, run the following commands:
  ```sh
  pnpm dev
  ```

### Building and Previewing the Application
To build the application in production mode, use:
  ```sh
  pnpm prod
  ```

To preview the production build locally, run:
  ```sh
  pnpm preview
  ```

### Deploying to the Server
To deploy the application, use the command:
  ```sh
  pnpm deploy
  ```

## 🕸️ GraphQL Operations
Below are the core GraphQL operations used in the Enigma app to manage encrypted notes:
  - Get book:
    ```graphql
    query GetBook($id: ID) {
      books(id: $id) {
        id
        title
        description
        author
        picture
        file
        date
        ai
      }
    }
    ```

  - Get books:
    ```graphql
    query GetBooks{
      books {
        id
        title
        description
        author
        picture
        file
        date
        ai
      }
    }
    ```

  - Login user:
    ```graphql
    mutation LoginUser($credentials: LoginCredentials!) {
      loginUser(credentials: $credentials) {
        data
      }
    }
    ```

  - Register user:
    ```graphql
    mutation RegisterUser($credentials: RegisterInput!) {
      registerUser(credentials: $credentials) {
        data
      }
    }
    ```

  - Update user:
    ```graphql
    mutation UpdateUser($credentials: UpdateUserInput!) {
      updateUser(credentials: $credentials) {
        data
      }
    }
    ```

  - Add like a book:
    ```graphql
    mutation LikeMutation($bookId: ID!, $userId: ID!) {
      addLike(bookId: $bookId, userId: $userId) {
        data
      }
    }
    ```

  - Remove like a book:
    ```graphql
    mutation UnlikeMutation($bookId: ID!, $userId: ID!) {
      removeLike(bookId: $bookId, userId: $userId) {
        data
      }
    }
    ```

  - Create book:
    ```graphql
    mutation CreateBook($input: CreateBookInput!) {
      createBook(input: $input) {
        data
      }
    }
    ```

## 🎥 Demo

You can view a working version of the project here:
👉 https://echoverse.wgwcompany.workers.dev/

### Demo credentials:

| Login | Password |
|-------|----------|
| John  | 12345    |

Video walkthrough of the specification:
🎥 https://youtu.be/-lCgQ6-MzIw

## 📜 Certification

This project was submitted as part of the CS50’s Web Programming with Python and JavaScript course offered by Harvard University.
Upon successful completion, I was awarded a certificate, which is available here:

🎓 [View Certificate](https://certificates.cs50.io/6f5116d0-882d-4fc1-9dc6-0c96c5d4c7b1.pdf)