FROM node:9.11-slim AS vue-app-builder
ADD . /vue-app
WORKDIR /vue-app
RUN npm install
RUN npm run-script build

FROM openresty/openresty:alpine-fat
COPY --from=vue-app-builder /vue-app/dist /usr/local/openresty/nginx/html
