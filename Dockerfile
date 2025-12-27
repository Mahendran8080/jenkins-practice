# Use lightweight Node image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package files first (layer caching)
COPY package*.json ./

# Install dependencies (express)
RUN npm install

# Copy application source code
COPY . .

# App runs on port 3000
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
