## `index.js`

### Purpose
`index.js` is a minimal Express.js application that serves as a **demo endpoint** for a Jenkins CI pipeline that uses *poll SCM* to trigger builds.  
When the pipeline runs, this file starts a web server on port **3000** and responds to the root URL (`/`) with a friendly greeting:

```
Hello from Jenkins CI Pipeline with poll SCM
```

This simple server is useful for:

- Verifying that the CI pipeline has successfully deployed the application.
- Providing a quick health‑check endpoint that can be polled by Jenkins or other monitoring tools.

---

### Main Functions & Logic

| Section | Description |
|---------|-------------|
| `const express = require('express');` | Imports the Express framework. |
| `const app = express();` | Creates an Express application instance. |
| `app.get('/', (req, res) => { ... });` | Registers a GET route for the root path. When a request is received, it sends a plain‑text response. |
| `const PORT = 3000;` | Defines the port on which the server will listen. |
| `app.listen(PORT, () => { ... });` | Starts the HTTP server and logs a message once it’s ready. |

The logic is intentionally straightforward: start a server, expose a single route, and log the listening port. This keeps the file lightweight and easy to understand for CI/CD demonstrations.

---

### Usage Example

1. **Install dependencies** (if not already done):

   ```bash
   npm install express
   ```

2. **Run the server**:

   ```bash
   node index.js
   ```

   You should see:

   ```
   Server running on port 3000
   ```

3. **Access the endpoint**:

   ```bash
   curl http://localhost:3000
   ```

   Response:

   ```
   Hello from Jenkins CI Pipeline with poll SCM
   ```

> **Tip:** In a Jenkins pipeline, you can use `curl` or a browser to confirm that the build has deployed the application correctly.

---

### Extending the Demo

If you need additional routes or middleware, simply add them before the `app.listen` call. For example:

```js
app.get('/health', (req, res) => res.send('OK'));
```

This will expose a `/health` endpoint that can be used for health checks.