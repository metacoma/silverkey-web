FROM node:9.11-slim AS vue-app-builder
ADD ./vue-app /vue-app
WORKDIR /vue-app
RUN npm install
RUN npm run-script build

# XXX extract etcdctl from prebuild etcd container?
FROM alpine:latest AS etcd-stuff
ENV ETCD_VER v3.3.6
ENV GITHUB_URL=https://github.com/coreos/etcd/releases/download
ENV DOWNLOAD_URL=${GITHUB_URL}
ADD ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
RUN mkdir /etcd
RUN tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /etcd --strip-components=1

EXPOSE 80
FROM openresty/openresty:alpine-fat
COPY --from=etcd-stuff /etcd/etcdctl /usr/local/bin/etcdctl
RUN /usr/local/bin/etcdctl --version
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
