#!/usr/bin/env bash

set -e

echo "Starting full FFmpeg build with Netint and extra codecs..."

./configure \
  --pkg-config-flags="--static" \
  --enable-gpl --enable-nonfree \
  --enable-libx264 --enable-libx265 --enable-libvmaf --enable-openssl \
  --enable-libfreetype --enable-libass --enable-libvorbis --enable-libopus \
  --enable-libmp3lame --enable-libvpx --enable-libaom --enable-libopenjpeg \
  --enable-libbluray --enable-libsnappy --enable-libsoxr --enable-libzmq \
  --enable-libwebp --enable-libxcb --enable-pthreads \
  --enable-ffprobe --enable-shared --disable-ffplay \
  --enable-ni_quadra --disable-ni_logan \
  --extra-ldflags="-lm -ldl" --extra-libs="-lpthread"

make -j $(nproc)
make install
ldconfig

echo "✅ Full FFmpeg build complete!"
