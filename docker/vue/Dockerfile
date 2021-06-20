FROM node:12.13.0

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8090

CMD ["sh", "-c", "npm install; npm run serve"]
