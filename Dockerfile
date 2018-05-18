FROM node:9.11-slim AS vue-app
ADD . /vue-app
WORKDIR /vue-app
RUN npm install
RUN npm build
