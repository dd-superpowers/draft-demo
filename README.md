# Demo Devoxx Fr

```bash
cd Dropbox/dd-superpowers/draft-demo
```

## ✋ Select the default builder

```bash
docker context use default
# or desktop-linux 🤔 need to check
```

## 🐳 Images

### First Build

Initialize the `Dockerfile`
```bash
./initialize.sh 
```

Start Docker **Compose** with `--watch` and `--build`
```bash
docker compose up --watch --build
```

Go to the **Images** view:
- Search for the `restos` image
- Show the details of the image

### Remediation, then Second Build

- 👀 Look at the **Recommended fixes** choices
- 🐳 Use one of the choices (update the `Dockerfile` in another terminal)
- ⏳ Wait for the rebuild
- 👀 Show the details of the image 🎉 + **image size** 😡

### Third Build: multi-stage builds

Stay in `--watch` mode and run the below command (from another terminal):
```bash
./multistage.sh
```

- ⏳ Wait for the rebuild
- 👀 Show the details of the image 🎉 + **image size** 🙂

### Fourth Build: Scratch or Distroless images

Stay in `--watch` mode and run the below command (from another terminal):
```bash
./scratch.sh
```

- ⏳ Wait for the rebuild
- 👀 Show the details of the image 🎉 + **image size** 😍

## 🐳 Builds

Go to the **Builds** view:
- Show the Info, Source, Logs, History panels

## 🐳 Containers

Go to the **Containers** view:
- Search for `draft-demo` -> un-collapse the **Compose** project
- 1️⃣ Select the **Redis** container:
  - Show the all the panels (**Stats** included)
    - Show **MOUNT** & **VOLUME** into the **Files** panel
      - Show the content pf the `/scripts` directory
    - Then, go to the **Exec** panel
    ```bash
    cd /scripts
    ls
    ./read.sh
    ```
- 2️⃣ Return to the containers list: launch the webapp in the browser
- 3️⃣ Return to the containers list and select the **Webapp** container:
  - Go to the **Exec** panel to fix the `info.txt` file (ok, this is a dumb example)
    - **Exec** will fail (because of the `scratch` image)
    - Use **Docker Debug**, change the content of `info.txt`
    - Show again the webapp in the browser

## 🐳 Builds Again
Sometimes we need to build the images for various architectures

✋ Stop Docker **Compose**: `docker compose down` (the clean way)

Update the `Dockerfile`
```bash
./platforms.sh
```
- Show the `Dockerfile`
- Show the Bake file: `docker-bake.hcl`

Build 🚀:
```bash
docker buildx bake --push
```

✋ Return to the **Builds** view to show the changes

