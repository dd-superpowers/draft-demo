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

## 🐙 Compose
If you are using Docker Desktop > 4.40, you can edit the `compose.yaml` file and update the `develop` section by uncommenting the `rebuild` action using `include` and comment the 2 following `rebuild` blocks

```yaml
    develop:
      watch:
        - action: sync
          path: ./public
          target: /app/public
        # Uncommented section
        - action: rebuild
          path: .
          include: ["*.go", "Dockerfile"]
        # comment this 2 blocks  
        #- action: rebuild
        #  path: ./Dockerfile
        #- action: rebuild
        #  path: ./main.go
```

Comment the definition of the Message environment variable in the `compose.yaml` file:
```yaml
    environment:
      # - MESSAGE=🎉 Hello from 🐳 Compose 👋
```

Restart the Compose application with
```bash
docker compose up --watch
```

You should now see the default message `this is a message` displayed in the webapp
In the `main.go` file, update the message to `Hello from 🐙 Compose 👋` and save the file.

Compose will detect the change and rebuild the image automatically for you
```shell
...
webapp-1           | 🐳 Application name: Zany Chicken
                   ⦿ Rebuilding service(s) ["webapp"] after changes were detected...
                   ⦿ service(s) ["webapp"] successfully built
webapp-1 exited with code 2
webapp-1 has been recreated

v View in Docker Desktop   o View Config   w Disable Watch
```
Refresh the webapp in the browser and you should see the new message displayed.

Now hit the `o` key to open the configuration file in Docker Desktop, you will see a page showing your compose file(s).    
And if you go over some keywords like `ports`, `volumes`, `depends_on`..., and you click on them, you will get access to the learning center explanations.

## 🐳 Kubernetes
Now that we're in the Compose file Viewer in Docker Desktop, you can click on the `Convert and deploy to Kubernetes` button.
If the button is inactive, go to `Settings > Features in development > Experimental features`, be sure it's enabled and `Enable Compose Bridge command line` is checked.

If you haven't already setup Kubernetes in Desktop, you will be prompted to do so.
After that, Docker Desktop will ask you to stop your Compose application to avoid port conflicts and will generate the Kubernetes manifests and deploy them for you.

If you go to the Kubernetes tab via `Setting > Kubernetes`, you will be able to choose between 2 flavors of Kubernetes:
* single node KubeAdm cluster
* multi nodes Kind cluster

You will be able to choose if you want to see or not the system containers used to start Kubernetes and if you want to deploy the default Kubnernetes dashboard.

## 🐳 Docker Model Runner
It's time to discover the new feature released in Docker Desktop 4.40: Docker Model Runner.

Go to the **Settings** view:
- Choose Features in development
- Enable Docker Model Runner

Now the model runner is enabled and you can start download models to use it
- `docker model status`
- `docker model pull ai/mistral`
- `docker mode list`
```shell
docker model list                                                                                2m 19s 22:17:43
MODEL                                     PARAMETERS  QUANTIZATION    ARCHITECTURE  MODEL ID      CREATED      SIZE
ai/llama3.2:1B-Q8_0                       1.24 B      Q8_0            llama         a15c3117eeeb  2 weeks ago  1.22 GiB
ai/smollm2                                361.82 M    IQ2_XXS/Q4_K_M  llama         354bf30d0aa3  3 weeks ago  256.35 MiB
ai/mxbai-embed-large                      334.09 M    F16             bert          e5e025b145ac  3 weeks ago  638.85 MiB
ai/qwen2.5:latest                         7.62 B      IQ2_XXS/Q4_K_M  qwen2         d23f1d398f07  2 weeks ago  4.36 GiB
ai/qwen2.5:3B-Q4_K_M                      3.09 B      IQ2_XXS/Q4_K_M  qwen2         41045df49cc0  6 days ago   1.79 GiB
ai/mistral                                7.25 B      IQ2_XXS/Q4_K_M  llama         395e9e2070c7  2 weeks ago  4.07 GiB
```
- `docker model run ai/mistral "list pizza in Paris which sell Hawaiian pizza"`
```shell
docker model run ai/mistral "list pizza in Paris which sell Hawaiian pizza"                          8s 22:21:48
 In Paris, you might have a harder time finding traditional Hawaiian pizza as it's not as popular there compared to other parts of the world. However, some pizzerias do offer it or variations of it. Here are a few pizzerias in Paris known for their creative pizzas, some of which might have a Hawaiian-style option:

1. Pizza Pompidou: Located in the Marais district, Pizza Pompidou is a popular spot known for its inventive pizzas. They might offer a version of Hawaiian pizza.

2. La Famille Véron: This pizzeria in the Bastille area often has a creative menu with interesting toppings. It's possible they offer a Hawaiian-style pizza.

3. Pizzeria Popolare: Located in the 10th arrondissement, Pizzeria Popolare is another popular spot with a variety of pizza options. They might have a pizza with ham and pineapple, which could be considered a Parisian take on Hawaiian pizza.

4. Il Pizzaiolo: Located in the 18th arrondissement, Il Pizzaiolo offers traditional Neapolitan pizzas, but they might also have some creative options that could include ham and pineapple.

5. Le Verre Volé: While not a pizzeria, Le Verre Volé is a popular bar in the Canal Saint-Martin area that often has a pizza night with creative pizzas, including potential Hawaiian-style options.
```
- `docker model rm ai/mistral`

## 🐳 Docker Desktop CLI 
There is a new way to interact with Docker Desktop from the command line. `docker desktop` command offers you some options to manipulate Desktop application.

```bash
docker desktop --help                                                                                                                                                                                                      5m 35s 11:49:25
Usage:  docker desktop COMMAND

The Docker Desktop CLI lets you perform key operations such as starting, stopping,
restarting, and updating Docker Desktop directly from the command line.

Management Commands:
  disable     Disable a feature
  enable      Enable a feature

Commands:
  logs        Print log entries
  restart     Restart Docker Desktop
  start       Start Docker Desktop
  status      Show the status of the Docker Desktop engines
  stop        Stop Docker Desktop
  update      Manage Docker Desktop updates
  version     Show the Docker Desktop CLI plugin version information

Run 'docker desktop COMMAND --help' for more information on a command.
```

So you can easily `start` and `stop` Docker Desktop from the command line.
```bash
docker desktop stop
⠙ Stopping Docker Desktop
docker desktop start
✓ Starting Docker Desktop
```