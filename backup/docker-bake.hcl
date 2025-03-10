variable "REPO" {
  default = "philippecharriere494"
}

variable "TAG" {
  default = "demo"
}

group "default" {
  targets = ["paris-restaurants-image"]
}

target "paris-restaurants-image" {
  context = "."
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = ["${REPO}/paris-restaurants:${TAG}"]
}

# docker buildx bake --push --file docker-bake.hcl