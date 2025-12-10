FROM node:20-alpine
WORKDIR /app

COPY package*.json ./
RUN npm clean-install

COPY . .

# entry point is index.js
CMD [ "npm", "start" ]