# syntax=docker/dockerfile:1.5

# Stage 1: Build
FROM node:20-alpine AS build
WORKDIR /app

ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}

COPY package*.json ./
RUN npm clean-install

COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS production
WORKDIR /app

COPY --exclude=src --from=build /app ./

CMD ["sh", "-c", "npm run preview -- --host $HOST --port $PORT"]