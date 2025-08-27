# Lightpanda Browser

Official Docker image for [Lightpanda
browser](https://github.io/lightpanda-io/browser).

Lightpanda is the open-source browser made for headless usage:

- Javascript execution
- Support of Web APIs
- Compatible with CDP clients like Playwright, Puppeteer or Chromedp.

Fast web automation for AI agents, LLM training, scraping and testing:

- Ultra-low memory footprint (9x less than Chrome)
- Exceptionally fast execution (11x faster than Chrome)
- Instant startup

## Usage

Using docker run.

```
$ docker run -d --name lightpanda -p 9222:9222 lightpanda/browser:nightly
```

Using docker compose.

```
services:
    lightpanda:
        image: lightpanda/browser:nightly
        restart: unless-stopped
        ports:
            - '9222:9222'
```
