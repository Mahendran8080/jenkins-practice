## `src/app.js`

### Purpose
`app.js` is the entry point of the documentation‑generation agent.  
It exposes a single HTTP endpoint (`/trigger-docs`) that, when hit, scans the repository for source files, generates Markdown documentation for each file, and pushes the resulting docs back to GitHub.  
The server runs on the port defined in `config.js` and logs progress to the console.

---

### Main Logic

| Step | Description | Key Functions |
|------|-------------|---------------|
| 1 | **HTTP Server Setup** | `express()` creates an Express app. |
| 2 | **Endpoint `/trigger-docs`** | Triggered via a GET request. |
| 3 | **File Discovery** | `getCodeFiles()` (from `scanner.js`) returns an array of objects `{ path, content }` for every source file in the repo. |
| 4 | **Documentation Generation** | For each file, `generateDoc(file.path, file.content)` (from `generator.js`) produces a Markdown string. |
| 5 | **Push to GitHub** | `pushToGithub(file.path, markdown)` (from `github.js`) commits the generated Markdown back to the repository. |
| 6 | **Rate‑limit Mitigation** | `await sleep(2000)` pauses 2 s between each file to avoid hitting GitHub’s API limits. |
| 7 | **Response** | On success, returns `{ status: "Done", message: "All docs updated on GitHub!" }`. On error, returns a 500 status with the error message. |
| 8 | **Server Start** | `app.listen(config.port)` starts the server and logs the URL. |

---

### Usage Example

```bash
# Start the agent
node src/app.js
```

Once running, trigger the documentation pipeline:

```bash
curl http://localhost:3000/trigger-docs
```

You should see console logs similar to:

```
🤖 Agent is live on http://localhost:3000
🚀 Agent Started...
🔍 Analyzing: src/utils/helpers.js
🔍 Analyzing: src/components/Button.jsx
...
All docs updated on GitHub!
```

The response will be:

```json
{
  "status": "Done",
  "message": "All docs updated on GitHub!"
}
```

> **Note:**  
> - Ensure `config.js` contains a valid `port` and GitHub credentials.  
> - The agent assumes the repository is already cloned locally and that the GitHub token has write access to the target branch.