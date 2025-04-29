docker run –rm -e POSTGRES_PASSWORD=dev -p 5432:5432 postgres:17.1
------------
## INITIALIZE

- Open Docker Desktop
- Open the terminal
```bash
cd Dropbox/dd-superpowers/draft-demo

eza -T -L 2

bat compose.yaml
# Explain the compose file
./initialize.sh
docker compose up --watch --build
```

**Show** the **Container view** to run the web application

**Go** to the **Images view** :
- Search for the `food-places` image
- Show the details of the image


**Return** the **Container view**
> to wait the scout scan to finish
- Go into the **redis** container
  - Show the **Logs**
  - Show the **Stats**
  - Show the **Files** (show the mounts)
  - Show the **Exec** panel 
    - `cd /scripts`
    - `ls`
    - `./read.sh`

------------
## FIRST REMEDIATION

**Go Back** to the **Images view** :
- speak about the vulnerabilities and scout
- collapse some of the vulnerabilities

Show the **Recommended fixes** choices
- Select the recommended fix
- Return to the terminal and open a **second one**
- Update the `Dockerfile` with the recommended fix
- Save the file
- Show the log of Compose and Wait for the rebuild
- Show the details of the image in the **Images view**
- Show the **Vulnerabilities** panel
- 🎉 Less vulnerabilities, but still
- 😡 The size of the image is big

------------
## DECREASE THE SIZE WITH MULTI-STAGE BUILDS
> And fix all the vulnerabilities

**Stay in the `--watch` mode** and run the below command (from another terminal):
```bash
./multistage.sh
```
- Show the details of the image in the **Images view**
- Show the **Vulnerabilities** panel
- There is still a vulnerability
- 🙂 The size of the image is a lot smaller

But I can do better:
```bash
./scratch.sh
```
- Show the details of the image in the **Images view**
- Show the **Vulnerabilities** panel
- 🙂 The size of the image is even more smaller
- There is still a vulnerability: 
  - **Collapse and show the details**
  - **FIX IT**: `FROM golang:1.24-alpine AS builder`
- 🎉🎉🎉 No more vulnerabilities


------------
## LET SPEAK ABOUT THE **BUILDS** 

- Go to the **Builds view**:
- Select the last build (`dd-scout` / change the *created order* if needed)
- Show the 
  - Info panel, 
  - Source panel, + **click inside the code source**
  - Logs panel, + **speak about the cache**
  - History panel, + **speak about improvement**

------------
## DOCKER DEBUG

**First Check that the application is still running**

- Now I want to change the text at the bottom of the page
- Go to the **Container view**
  - Try to open the **Exec panel**
  - It doesn't work (it's normal: distroless or scratch image)
  - Solve it with **Docker Debug**

------------
## BACK TO DOCKER SCOUT
> But with the CLI

- Stop Compose Watch
- In the terminal, run the below command:
```bash
# First
./initialize.sh
# Build the image
docker build -t food-places:demo .
# Then run the scan
docker scout quickview food-places:demo
docker scout recommendations food-places:demo
docker scout cves --format only-packages --only-package-type golang food-places:demo
docker scout cves --format markdown --output report.md food-places:demo

```

------------
## LAST BUT NOT LEAST
Gordon (beta version)
- new conversation
- rate my dockerfile
- `how can I decrease the size of the image?`
