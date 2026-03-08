FROM ghcr.io/openclaw/openclaw:main

ARG DEBIAN_FRONTEND=noninteractive
USER root

RUN apt-get update
RUN apt-get install -y --no-install-recommends vim

# gosu for dropping privileges in entrypoint
RUN apt-get install -y --no-install-recommends gosu

# Chromium + Xvfb for browser automation (Playwright)
RUN apt-get install -y --no-install-recommends xvfb && \
    mkdir -p /home/node/.cache/ms-playwright && \
    PLAYWRIGHT_BROWSERS_PATH=/home/node/.cache/ms-playwright \
    node /app/node_modules/playwright-core/cli.js install --with-deps chromium && \
    chown -R node:node /home/node/.cache/ms-playwright

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER node
