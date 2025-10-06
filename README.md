# factorio-server

## System preparation and usage

Clone the repo, then `cd` into it; then do:

```shell
bin/install-docker
bin/run -d
```

Optionally provide environment variables via `.env` file.

## Container variants

Set the `CONTAINER_VARIANT` env var to one of the targets from `Dockerfile`
(via `.env` file).

Choose from:

- `factorio`
- `factorio-rpi5`
