## `src/github.js`

### Purpose
`src/github.js` is a small helper module that abstracts the interaction with the GitHub REST API for pushing documentation files to a repository.  
It uses the official **Octokit** client to create or update files in a `docs/` folder of the configured repository. The module is designed to be used by other parts of the project that generate or modify documentation and want to keep it in sync with GitHub automatically.

### Key Function – `pushToGithub(filePath, content)`
| Parameter | Type | Description |
|-----------|------|-------------|
| `filePath` | `string` | The local path of the source file (e.g., `src/utils.js`). |
| `content` | `string` | The Markdown content that should be written to GitHub. |

#### Workflow
1. **Path Normalisation**  
   The function converts the supplied `filePath` into a GitHub path inside the `docs/` directory, replacing back‑slashes with forward slashes and changing the file extension from `.js` to `.md`.

2. **Check for Existing File**  
   It attempts to fetch the current file from GitHub to obtain its SHA.  
   - If the file exists, the SHA is used to update it.  
   - If the file does not exist (404), the SHA is omitted so that a new file is created.

3. **Create / Update File**  
   `octokit.rest.repos.createOrUpdateFileContents` is called with:
   - `owner`, `repo` from `config.github`
   - `path` (the normalized docs path)
   - `message` – a commit message that includes the original file name
   - `content` – Base64‑encoded Markdown
   - `sha` – optional, only when updating

4. **Error Handling**  
   Any error is logged to the console. If the error status is `403` or `404`, a helpful tip is printed to remind the user to check the token’s permissions.

5. **Return Value**  
   Returns `true` on success, `false` on failure.

### Usage Example
```js
import { pushToGithub } from './github.js';

// Assume we have generated Markdown for a file
const sourceFile = 'src/components/Button.js';
const markdown = `
# Button Component

This component renders a clickable button.
`;

// Push the documentation to GitHub
pushToGithub(sourceFile, markdown)
  .then(success => {
    if (success) console.log('Documentation updated!');
  })
  .catch(err => console.error('Unexpected error:', err));
```

> **Prerequisites**  
> - A `config.js` file exporting a `github` object with `token`, `owner`, and `repo`.  
> - The token must have **Contents: Read & Write** permissions for the target repository.

This module is intentionally lightweight and can be reused in scripts or CI pipelines that need to keep a GitHub repository’s documentation in sync with local source files.