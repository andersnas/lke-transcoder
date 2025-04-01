# Netint FFmpeg Builder

Full-featured FFmpeg image with:
- Netint Quadra support (libxcoder)
- VMAF, OpenSSL, libx264, libx265, and more
- Optimized for use in Linode Kubernetes Engine (LKE)

## 🧪 To Build

On macOS with Docker Buildx:

```bash
docker buildx build \
  --platform linux/amd64 \
  --no-cache \
  -t yourdockerhubuser/netint-vpu:latest \
  --push ./docker
