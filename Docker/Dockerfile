# ======= Stage 1: Build =======
FROM ubuntu:24.04 as builder

LABEL org.opencontainers.image.authors="NETINT Technologies" \
      org.opencontainers.image.description="Full-featured FFmpeg with Netint, VMAF, x264, x265, SSL"

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    pkg-config git gcc make g++ sudo wget uuid-runtime udev unzip yasm nvme-cli \
    autoconf automake libtool libpci-dev libnuma-dev curl python3 python3-pip \
    libssl-dev libx264-dev libx265-dev libvmaf-dev libfreetype6-dev libass-dev \
    libvorbis-dev libopus-dev libmp3lame-dev libvpx-dev libaom-dev libopenjpeg-dev \
    libbluray-dev libsnappy-dev libsoxr-dev libzmq3-dev libwebp-dev libxcb1-dev \
    libxcb-shm0-dev libxcb-xfixes0-dev dnsutils iputils-ping meson ninja-build

# Install libxcoder
WORKDIR /NI_Release
RUN git clone https://github.com/NETINT-Technologies/netint_libxcoder.git
WORKDIR /NI_Release/netint_libxcoder
RUN bash build.sh

# Install and build full ffmpeg
WORKDIR /NI_Release
RUN git clone https://github.com/NETINT-Technologies/netint_ffmpeg.git
COPY build_ffmpeg_full.sh /NI_Release/netint_ffmpeg/build_ffmpeg_full.sh
WORKDIR /NI_Release/netint_ffmpeg
RUN chmod +x build_ffmpeg_full.sh && ./build_ffmpeg_full.sh
RUN make install

# ======= Stage 2: Runtime =======
FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    libnuma1 libssl3 libx264-164 libx265-199 libvmaf1 libfreetype6 libass9 \
    libvorbis0a libopus0 libmp3lame0 libvpx7 libaom3 libopenjp2-7 \
    libbluray2 libsnappy1v5 libsoxr0 libzmq5 libwebp7 libxcb1 libxcb-shm0 \
    libxcb-xfixes0 dnsutils iputils-ping && apt-get clean

COPY --from=builder /usr/local/bin/ffmpeg /usr/local/bin/
COPY --from=builder /usr/local/bin/ffprobe /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY --from=builder /NI_Release/netint_libxcoder/bin/ /usr/local/bin/

ENV LD_LIBRARY_PATH=/usr/local/lib/

WORKDIR /NI_Release
CMD ["sleep", "infinity"]
