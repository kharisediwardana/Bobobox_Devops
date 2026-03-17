FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json from app folder
COPY app/package.json ./ 

# Install dependencies
RUN npm install

# Copy app
COPY app/ ./

# Build
RUN npm run build

# Expose default
EXPOSE 3000

# Start
CMD ["npm", "start"]