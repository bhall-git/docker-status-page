# Stage 1: Generate static HTML
FROM ubuntu:24.04 AS builder

WORKDIR /build

COPY generate-page .

RUN chmod +x generate-page && \
    ./generate-page > index.html

# Stage 2: Production NGINX
FROM nginxinc/nginx-unprivileged:stable-alpine

COPY --from=builder /build/index.html /usr/share/nginx/html/index.html

EXPOSE 8080
# Check that NGINX is serving the status page
HEALTHCHECK --interval=30s --timeout=3s \
  --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1

