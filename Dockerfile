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
ADD backend/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
# XXX multistage
RUN apk update && apk add                       \
  alpine-sdk                                    \
  skalibs                                       \
  skalibs-dev
WORKDIR /tmp
RUN git clone https://github.com/jprjr/sockexec.git   \
    && cd sockexec                                    \
    && make install
WORKDIR /tmp
RUN git clone https://github.com/jprjr/idgaf          \
    && cd idgaf                                       \
    && gcc -o /usr/local/bin/idgaf idgaf.c            \
    && rm -rf /tmp/idgaf /tmp/sockexec

RUN opm install                                       \
      jprjr/lua-resty-exec


ADD backend/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
