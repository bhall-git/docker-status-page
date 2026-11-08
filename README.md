# Docker Status Page — Multi-Stage Build

A containerized server status page built as part of the KubeCraft DevOps OS Docker training.

## Project Overview

This project demonstrates how to combine Bash scripting, Docker multi-stage builds, NGINX, non-root execution, and container health checks.

A Bash script generates a static HTML status page during the Docker image build. The generated page is then copied into a lightweight NGINX runtime image.

## Architecture

Bash Generator (Ubuntu 24.04)
        |
        v
Generated index.html
        |
        v
NGINX Unprivileged (Alpine)
        |
        v
HTTP Port 8080

## Technologies

- Docker and Docker BuildKit
- Bash scripting
- Ubuntu 24.04
- NGINX Unprivileged (Alpine)
- HTML and CSS

## Build the Image

docker build -t docker-status-page:v2 .

## Run the Container

docker run -d \
  --name docker-status \
  -p 8080:8080 \
  docker-status-page:v2

## Test the Application

curl -i http://localhost:8080

Expected HTTP response: 200 OK

Open http://localhost:8080 in a browser.

## Verify Non-Root Execution

docker exec docker-status id

The container runs as the nginx user (UID 101), not root.

## Verify Container Health

docker ps --filter name=docker-status

docker inspect \
  --format='{{json .State.Health}}' \
  docker-status

The health check uses wget to test the local NGINX HTTP endpoint.

## Security and Docker Best Practices

- Multi-stage Docker build
- Minimal Alpine-based runtime image
- Non-root NGINX process
- Unprivileged HTTP port 8080
- Docker HEALTHCHECK instruction
- .dockerignore to reduce build context
- Versioned Docker images

## Key Learning Outcomes

- Generate application content during Docker builds
- Separate build and runtime environments
- Reduce runtime image dependencies
- Configure and verify container health checks
- Validate non-root container execution
- Troubleshoot Bash scripts and Docker builds

## Author

GitHub: https://github.com/bhall-git
