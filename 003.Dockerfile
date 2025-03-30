# `builder` stage
FROM golang:1.22-alpine AS builder 

WORKDIR /app
COPY main.go .
COPY go.mod .

RUN <<EOF
go mod tidy 
go build -o tiny-service
EOF

# `final` stage
FROM scratch
WORKDIR /app
COPY --from=builder /app/tiny-service .

COPY public ./public 
CMD ["./tiny-service"]
