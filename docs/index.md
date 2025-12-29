## `index.js`

| Item | Description |
|------|-------------|
| **Location** | Root of the repository (or `src/` if the project is structured that way) |
| **Language** | JavaScript (Node.js) |
| **Dependencies** | `express` (web framework) |

### File Purpose
`index.js` is the entry point for a minimal **Node.js + Express** application.  
It starts an HTTP server that listens on port **3000** and responds with a simple greeting message when the root URL (`/`) is accessed.  
In the context of the repository, this file is used as a lightweight demo endpoint that is built and deployed by the Jenkins CI pipeline.

### Key Logic

```js
const express = require('express');
const app = express();
```
* Imports the Express framework and creates an application instance.

```js
app.get('/', (req, res) => {
  res.send('Hello from Jenkins CI Pipeline with poll SCM');
});
```
* Registers a single GET route for `/`.  
* The response text is intentionally descriptive so that anyone hitting the endpoint can confirm that the deployment was triggered by Jenkins (the message mentions “Jenkins CI Pipeline with poll SCM”).

```js
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```
* Starts the server on port 3000 and logs a confirmation message.

### DevOps Context
- **CI/CD**: The repository contains a Jenkinsfile that checks out the source code, installs dependencies (`npm install`), runs tests, builds a Docker image, and pushes it to a registry.  
- **Docker**: The Dockerfile (not shown here) typically uses `node:18-alpine` as the base image and copies `index.js` into the container.  
- **Deployment**: Once the Docker image is built, Jenkins pushes it to a registry and triggers a deployment (e.g., via Helm or a Kubernetes `Deployment` manifest).  
- **Polling SCM**: The Jenkins job is configured to poll the Git repository for changes. When a new commit is detected, the pipeline rebuilds the image and redeploys the application, ensuring that the latest version of `index.js` is always running.

> **Why this file matters**  
> Even though it contains only a single route, `index.js` demonstrates the end‑to‑end flow: source code → CI build → Docker image → CD deployment. It serves as a sanity check that the pipeline is functioning correctly and that the deployed container is reachable.