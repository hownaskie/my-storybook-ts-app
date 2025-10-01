# Use Node.js image
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /builder

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install dependencies as per lock file without making updates
RUN npm install --frozen-lockfile

# Copy the rest of the project files
COPY . .

# Expose the dev server port (Vite/CRA default is 5173 or 3000)
EXPOSE 5173

# Start the app (change if using CRA)
CMD ["npm", "run", "dev"]
