# Use an official Node.js runtime
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy the rest of the project
COPY . .

# Expose port
EXPOSE 5000

# Start the app
CMD ["node", "server.js"]

