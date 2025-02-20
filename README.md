# draft-demo

## Select the default builder

```
docker context use default
```

## Add the data

- Start the Compose project
- Open DD
- Go to the Exec panel of the Redis container
- Execute `/scripts/load.sh`


## Builders

```bash
docker buildx ls

docker context use <builder_name>
docker context rm <builder_name>
```