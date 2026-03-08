# :lobster: openclaw-full

[OpenClaw](https://github.com/openclaw/openclaw) is great. It's packed with advanced features that make a personal AI assistant pleasant to use.
However, many of these features require additional software and dependencies, like browser integration.

For most users this is fine because they install OpenClaw directly on their machines and simply add whatever is missing.
But when running OpenClaw in a container, we need a way to include and persist those dependencies in the image.

OpenClaw's official Docker image supports this - you can extend it locally by passing some predefined supported Docker arguments, or with a custom Dockerfile.
This repository automates that process: it rebuilds and publishes a pre-built image that bundles Chromium/Playwright (via Xvfb) for headless browser automation, plus a few small utilities.

It's opinionated and incomplete, but it provides a starting point for a more complete OpenClaw experience in a container.
Contributions are welcome!

## Usage

This is an example - adapt it to your needs:

```bash
mkdir -p data/workspace
chown -R 1000:1000 data/workspace
cp docker-compose.yml.example docker-compose.yml
cp .env.example .env  # Set OPENCLAW_GATEWAY_TOKEN (e.g. `openssl rand -hex 32`)
docker compose up -d
docker compose exec -it openclaw-gateway openclaw onboard  # Set bind to `lan` when running in a container
```

You can access the gateway at `http://localhost:18789`.
