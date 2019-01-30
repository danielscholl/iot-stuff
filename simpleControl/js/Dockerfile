FROM node:8

WORKDIR WORKDIR /usr/src/app
COPY package.json ./

RUN npm install

ENV NODE_ENV=production LOG_LEVEL=info
COPY index.js .
COPY lib ./lib

CMD ["node", "index.js"]
