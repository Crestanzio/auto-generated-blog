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

# COPY --exclude=src --from=build /app ./

COPY --from=build /app/build             ./build
COPY --from=build /app/public            ./public
COPY --from=build /app/index.html        ./index.html
COPY --from=build /app/node_modules      ./node_modules
COPY --from=build /app/package.json      ./package.json
COPY --from=build /app/package-lock.json ./package-lock.json
COPY --from=build /app/vite.config.js    ./vite.config.js

CMD ["sh", "-c", "npm run preview -- --host $HOST --port $PORT"]