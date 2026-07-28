# Stage 1: Build & Prune Dependencies
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Security-Hardened Minimal Runtime
FROM node:22-alpine
WORKDIR /app

# Run as non-privileged 'node' user to reduce host attack surface
USER node

# Copy dependencies and application source with correct ownership
COPY --chown=node:node --from=builder /app/node_modules ./node_modules
COPY --chown=node:node package*.json ./
COPY --chown=node:node src ./src

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

CMD ["node", "src/server.js"]
