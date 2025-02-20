FROM golang:1.22.4
WORKDIR /app
COPY main.go .
COPY go.mod .

RUN <<EOF
go mod tidy 
go build -o tiny-service
EOF

COPY public ./public 
CMD ["./tiny-service"]