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
$ docker run -d --name lightpanda -p 127.0.0.1:9222:9222 lightpanda/browser:latest
```

Using docker compose.

```
services:
    lightpanda:
        image: lightpanda/browser:latest
        restart: unless-stopped
        ports:
            - '127.0.0.1:9222:9222'
```

### Fetch command

```
$ docker run -rm lightpanda/browser:latest lightpanda fetch --dump html https://lightpanda.io
```

### CDP server

```
$ docker run -d --name lightpanda -p 127.0.0.1:9222:9222 lightpanda/browser:latest lightpanda serve --host 0.0.0.0 --port 9222 --log_level debug
```

### Program version

```
$ docker run -d --name lightpanda -p 127.0.0.1:9222:9222 lightpanda/browser:latest lightpanda version
```

## Environment variables

The image sets `LIGHTPANDA_DISABLE_CORE_DUMP=1` by default to disable core
dumps.

To re-enable core dumps, unset the variable at run time by passing `-e` with
the variable name only (and no value set in your shell):

```
$ docker run -d --name lightpanda -p 127.0.0.1:9222:9222 -e LIGHTPANDA_DISABLE_CORE_DUMP lightpanda/browser:latest
```
