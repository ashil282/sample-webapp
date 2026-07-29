# Stage 1: Build & Install Dependencies
FROM node:22-alpine AS builder

WORKDIR /app

# Copy dependency manifests
COPY package*.json ./

# Install dependencies cleanly
RUN npm ci

# Copy application source code
COPY . .

# Stage 2: Production Minimal Runtime (Hardened Security)
FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Copy built application and node_modules from builder stage
COPY --from=builder /app ./

# Use unprivileged non-root node user for security compliance
USER node

EXPOSE 3000

CMD ["npm", "start"]
