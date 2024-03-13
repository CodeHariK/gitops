# Stage 1: Build the Node.js application
FROM node:21-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package.json ./

# Install npm dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Node.js application
RUN npm run build

# Stage 2: Serve the application using Nginx
FROM nginx:1.25.4-alpine

# Copy the built application from the previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
