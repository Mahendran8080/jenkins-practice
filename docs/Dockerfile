## Dockerfile – Application Container Build

| Section | Description |
|---------|-------------|
| **Purpose** | Builds a lightweight, production‑ready Docker image for the Node.js application. |
| **Base Image** | `node:18-alpine` – a minimal Alpine Linux image with Node 18 pre‑installed. |
| **Working Directory** | `/app` – all subsequent commands run inside this directory. |
| **Dependency Layering** | `COPY package*.json ./` followed by `RUN npm install` allows Docker’s layer cache to be reused when only source files change, speeding up rebuilds. |
| **Source Copy** | `COPY . .` copies the entire project into the image after dependencies are installed. |
| **Port Exposure** | `EXPOSE 3000` declares that the container will listen on port 3000 (the default for the app). |
| **Entrypoint** | `CMD ["node", "index.js"]` starts the application when the container runs. |

### Key Logic Explained

1. **Base Image Selection**  
   ```dockerfile
   FROM node:18-alpine
   ```  
   Uses the official Node 18 image built on Alpine Linux, keeping the image size small (~70 MB) while providing the runtime needed for the app.

2. **Working Directory Setup**  
   ```dockerfile
   WORKDIR /app
   ```  
   All subsequent commands execute inside `/app`, ensuring a clean, predictable filesystem layout.

3. **Dependency Caching**  
   ```dockerfile
   COPY package*.json ./
   RUN npm install
   ```  
   By copying only the `package.json` and `package-lock.json` files first, Docker can cache the `npm install` layer. If only source files change, the dependency layer is reused, reducing build time.

4. **Source Code Copy**  
   ```dockerfile
   COPY . .
   ```  
   Copies the rest of the project into the image. This step occurs after dependencies are installed to avoid unnecessary cache invalidation.

5. **Port Declaration**  
   ```dockerfile
   EXPOSE 3000
   ```  
   Documents the port that the container will listen on. This is used by Docker Compose or Kubernetes to map host ports to the container.

6. **Application Startup**  
   ```dockerfile
   CMD ["node", "index.js"]
   ```  
   The default command runs the Node.js entry point. It can be overridden by `docker run -d --name myapp -p 3000:3000 myimage` or by a CI/CD pipeline step.

### DevOps Context

- **CI/CD Integration**  
  In a typical pipeline (GitHub Actions, GitLab CI, Jenkins, etc.), this Dockerfile is invoked during the *build* stage to produce a container image.  
  Example GitHub Actions snippet:

  ```yaml
  steps:
    - name: Build Docker image
      run: docker build -t myapp:${{ github.sha }} .
    - name: Push to registry
      run: |
        echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
        docker push myapp:${{ github.sha }}
  ```

- **Deployment**  
  The resulting image is typically deployed to a container orchestrator (Kubernetes, ECS, etc.) or a container‑runtime host. The `EXPOSE 3000` instruction informs the orchestrator of the service port, while the `CMD` ensures the application starts automatically.

- **Best Practices**  
  - **Layer Caching**: The `COPY package*.json` + `RUN npm install` pattern is a standard approach to keep rebuilds fast.  
  - **Alpine Base**: Reduces attack surface and image size.  
  - **Explicit Port**: Makes the container self‑describing and easier to debug.  

By following this Dockerfile, the project achieves a reproducible, lightweight runtime environment that integrates seamlessly into automated build and deployment pipelines.