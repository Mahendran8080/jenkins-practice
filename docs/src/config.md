## `src/config.js`

### Purpose
`src/config.js` centralises all runtime configuration for the application.  
It reads environment variables (via **dotenv**) and exposes a single, immutable `config` object that can be imported anywhere in the codebase. This approach keeps configuration logic in one place, simplifies testing, and guarantees that the rest of the application never needs to know where a value originates.

### Core Logic
```js
import dotenv from 'dotenv';
dotenv.config();          // Load .env file into process.env

export const config = {
    // Server port – defaults to 3000 if not defined
    port: process.env.PORT || 3000,

    // Hugging Face API token
    hfToken: process.env.HF_TOKEN,

    // GitHub integration credentials
    github: {
        token: process.env.GITHUB_TOKEN,
        owner: process.env.GITHUB_OWNER,
        repo: process.env.GITHUB_REPO
    }
};
```

| Property | Source | Description |
|----------|--------|-------------|
| `port` | `process.env.PORT` | Port number the server listens on. |
| `hfToken` | `process.env.HF_TOKEN` | Token for accessing Hugging Face APIs. |
| `github.token` | `process.env.GITHUB_TOKEN` | Personal access token for GitHub API calls. |
| `github.owner` | `process.env.GITHUB_OWNER` | GitHub account or organization owning the repo. |
| `github.repo` | `process.env.GITHUB_REPO` | Repository name to target. |

The file does **not** perform any validation or error handling; it simply mirrors the environment variables into a convenient object. If a required variable is missing, the consuming code should handle the `undefined` value appropriately.

### Usage Example
```js
// src/server.js
import { config } from './config.js';
import express from 'express';

const app = express();

app.listen(config.port, () => {
  console.log(`Server running on port ${config.port}`);
});
```

```js
// src/githubClient.js
import { config } from './config.js';
import { Octokit } from '@octokit/rest';

const octokit = new Octokit({
  auth: config.github.token
});

export async function getRepoInfo() {
  const { owner, repo } = config.github;
  const { data } = await octokit.repos.get({ owner, repo });
  return data;
}
```

> **Tip**: Keep a `.env.example` file in the repository that lists all required keys (`PORT`, `HF_TOKEN`, `GITHUB_TOKEN`, `GITHUB_OWNER`, `GITHUB_REPO`) so new developers can quickly set up their local environment.