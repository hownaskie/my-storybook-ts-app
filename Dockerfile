# Use Node.js image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json and lock file first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files
COPY . .

# Expose the dev server port (Vite/CRA default is 5173 or 3000)
EXPOSE 5173

# Start the app (change if using CRA)
CMD ["npm", "run", "dev"]
