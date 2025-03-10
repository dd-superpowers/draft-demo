# ✋ BUILDPLATFORM is a build argument that specifies the platform where the image is built.
FROM --platform=$BUILDPLATFORM golang:1.22-alpine AS builder
WORKDIR /app
COPY main.go .
COPY go.mod .

# ✋ TARGETOS and TARGETARCH are passed as build arguments.
ARG TARGETOS
ARG TARGETARCH

RUN <<EOF
go mod tidy 
# ✋ GOOS and GOARCH are set to the build arguments, so the binary is built for the target platform.
GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o tiny-service
EOF

FROM scratch
WORKDIR /app
COPY --from=builder /app/tiny-service .

COPY public ./public 
CMD ["./tiny-service"]

# docker buildx build \
#  --platform=linux/amd64,linux/arm64 \
#  --push -t philippecharriere494/paris-restaurants:0.0.1 .