FROM node:9.11-slim AS vue-app-builder
ADD ./vue-app /vue-app
WORKDIR /vue-app
RUN npm install
RUN npm run-script build

EXPOSE 80
FROM openresty/openresty:alpine-fat
ADD https://storage.googleapis.com/kubernetes-release/release/v1.9.5/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
COPY --from=vue-app-builder /vue-app/dist /usr/local/openresty/nginx/html
ADD backend/nginx.conf /etc/nginx/conf.d/default.conf
