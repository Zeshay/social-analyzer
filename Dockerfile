# Use Node 20 Alpine (lightweight)
FROM node:20-alpine

WORKDIR /usr/src/app

# Install Firefox (headless) and bash
RUN apk update && \
    apk add --no-cache firefox-esr bash

# Copy package files first for caching
COPY package*.json ./

# Install dependencies (npm ci works because package-lock.json exists)
RUN npm ci

# Copy the rest of the app
COPY . .

# Expose app port
EXPOSE 9005

# Start app
ENTRYPOINT ["npm", "start", "--", "--docker"]

