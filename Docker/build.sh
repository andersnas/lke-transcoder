docker buildx build \
  --platform linux/amd64 \
  --no-cache \
  -t andersnas/netint-vpu:latest \
  --push .