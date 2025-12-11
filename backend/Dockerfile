FROM node:20-alpine
WORKDIR /app

COPY package*.json ./
RUN npm clean-install

COPY . .

CMD [ "npm", "start" ]