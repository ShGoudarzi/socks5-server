# Set Go version as a build argument
ARG GOLANG_VERSION="1.19.1"

# Stage 1: Build the Go binary using the Go Alpine image
FROM golang:$GOLANG_VERSION-alpine as builder

# Install dependencies like timezone data
RUN apk --no-cache add tzdata

# Set the working directory inside the container
WORKDIR /go/src/github.com/serjs/socks5

# Copy go.mod and go.sum to download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the remaining source code
COPY . .

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -trimpath -installsuffix cgo -ldflags '-s -w' -o ./socks5

# Stage 2: Create a minimal final image using Alpine
FROM alpine:latest

# Install CA certificates and netcat for health check
RUN apk --no-cache add ca-certificates netcat-openbsd

# Copy the binary from the builder stage
COPY --from=builder /go/src/github.com/serjs/socks5/socks5 /

# Set the entrypoint to the socks5 binary
ENTRYPOINT ["/socks5"]

# Health check to verify if the SOCKS5 proxy is running on port 1080
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD nc -zv localhost 8080 || exit 1
