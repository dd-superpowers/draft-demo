The error means the default `docker` driver does not support multi-platform builds.

To fix this, you have two main options:

1. **Switch to the `docker-container` driver with `buildx`:**

```bash
docker buildx create --name container-builder --driver docker-container --bootstrap --use
```

Then build your multi-platform image with:

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t your-image-name .
```

Note: Images built with this driver are not automatically loaded into the Docker Engine image store but can be pushed directly to a registry with `--push`.

2. **Enable the containerd image store:**

- On **Docker Desktop**, enable containerd image store in Docker Desktop settings.
- On **Docker Engine standalone**, enable it via the daemon configuration file.

This allows multi-platform builds with the default `docker` driver.

---

**Summary:**  
Use `docker buildx` with the `docker-container` driver or enable containerd image store to build multi-platform images.

Sources:  
- https://docs.docker.com/build/building/multi-platform/  
- https://docs.docker.com/go/build-multi-platform/