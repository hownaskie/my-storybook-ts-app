# ------------------------
# Build Stage
# ------------------------
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package.json and lock file first for caching
COPY package*.json ./

# Install dependencies strictly using lockfile
RUN npm ci

# Copy the rest of the project files
COPY . .

# Build CRA app (output goes to /app/build)
RUN npm run build


# ------------------------
# Production Stage
# ------------------------
FROM node:20-alpine

WORKDIR /app

# Install a lightweight static file server
RUN npm install -g serve

# Copy built CRA artifacts from builder
COPY --from=builder /app/build ./build

# Expose port 3000 (CRA default)
EXPOSE 3000

# Serve built app
CMD ["serve", "-s", "build", "-l", "3000"]
