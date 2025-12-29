## `index.js`

### File Purpose
`index.js` is the entry point for a minimal **Node.js + Express** web application.  
It exposes a single HTTP GET endpoint (`/`) that returns a plain‑text greeting.  
The server listens on port **3000** and logs a startup message to the console.

This file is typically used in the repository’s CI/CD pipeline (e.g., a Jenkins job) to verify that the application builds correctly and that the basic HTTP endpoint is reachable after deployment.

---

### Key Logic

| Section | Description |
|---------|-------------|
| **Imports** | `const express = require('express');` pulls in the Express framework. |
| **App Instantiation** | `const app = express();` creates an Express application instance. |
| **Route Definition** | ```js
app.get('/', (req, res) => {
  res.send('Hello from Jenkins CI Pipeline with poll SCM');
});
``` <br>Defines a single route that responds with a static string. |
| **Server Startup** | ```js
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
``` <br>Starts the HTTP server on port 3000 and logs a message. |

---

### DevOps Context

| Context | Role |
|---------|------|
| **Jenkins CI Pipeline** | The file is referenced in the Jenkins job that **polls the SCM** for changes. When Jenkins detects a commit, it runs `npm install` and `node index.js` (or a test script that starts the server) to ensure the application can start successfully. |
| **Docker** | If the project includes a `Dockerfile`, this file is the main entry point (`CMD ["node", "index.js"]`). The container will expose port 3000, matching the `app.listen` call. |
| **Testing** | A simple health‑check script or `curl http://localhost:3000/` can be used in the pipeline to confirm the server is up and returning the expected string. |

---

### Typical Usage in a CI/CD Workflow

1. **Build Stage** – `npm install` installs dependencies.  
2. **Test Stage** – A lightweight test (e.g., `curl` or a unit test) hits `GET /` to verify the server responds.  
3. **Deploy Stage** – The application is packaged into a Docker image and pushed to a registry.  
4. **Run Stage** – The image is deployed to a staging or production environment where the same endpoint can be monitored.

---

#### Quick Reference

```bash
# Start locally
node index.js

# Verify
curl http://localhost:3000/
# => Hello from Jenkins CI Pipeline with poll SCM
```

This file serves as a simple, reliable “Hello World” that confirms the CI/CD pipeline, Docker image, and deployment are functioning correctly.