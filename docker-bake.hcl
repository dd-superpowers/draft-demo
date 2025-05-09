variable "REPO" {
  default = "philippecharriere494"
}

variable "TAG" {
  default = "demo"
}

group "default" {
  targets = ["multi-arch-build"]
}

target "multi-arch-build" {
  context = "."
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = ["${REPO}/restos:${TAG}"]
}

# docker buildx bake --push --file docker-bake.hcl