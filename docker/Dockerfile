# 1. Build Stage
FROM node:20-alpine AS builder

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


# 2. Runner Stage
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Copy spesific file from builder
COPY --from=builder /app ./

# Expose default
EXPOSE 3000

# Start
CMD ["npm", "start"]