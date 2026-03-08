# openclaw-full

OpenClaw is great. It's packed with advanced features that make a personal AI assistant pleasant to use.
However, many of these features require additional software and dependencies: things like Tailscale connectivity, browser integration, MCP servers, and more.

For most users this is fine because they install OpenClaw directly on their machines and simply add whatever is missing.
But when running OpenClaw in a container, we need a way to include and persist those dependencies in the image.

This repository extends the standard OpenClaw Docker image with additional dependencies and an entrypoint that handles volume permissions automatically. The container starts as root to fix ownership of `/home/node`, then drops to the `node` user via `gosu` before running OpenClaw. This means volumes mounted under `/home/node` (e.g. `/home/node/.openclaw`) work out of the box on platforms that mount volumes as root.

It's opinionated and incomplete, but it provides a starting point for a more complete OpenClaw experience in a container. Contributions are welcome!

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
