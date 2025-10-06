FROM debian:stable-slim AS box64-builder

RUN \
  --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
  --mount=target=/var/cache/apt,type=cache,sharing=locked \
  rm -f /etc/apt/apt.conf.d/docker-clean \
  && apt update \
  && apt install -y --no-install-recommends \
  git \
  cmake \
  build-essential \
  ca-certificates \
  python3

WORKDIR /build

RUN git clone https://github.com/ptitSeb/box64 .

FROM box64-builder AS box64-builder-rpi5

ENV OPTIONS="-D RPI5ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo"

RUN --mount=target=/build/build,type=cache \
  cd build \
  && cmake .. $OPTIONS \
  && make -j$(nproc) \
  && ls -la \
  && mkdir -p /artifacts \
  && cp box64 /artifacts

FROM factoriotools/factorio AS factorio-rpi5

COPY --from=box64-builder-rpi5 /artifacts/box64 /bin/
