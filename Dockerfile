# Stage 1: Build the Go binary
FROM golang:1.19.1-alpine as builder

# Install build dependencies
RUN apk --no-cache add tzdata

WORKDIR /go/src/github.com/serjs/socks5

# Copy source files
COPY . .

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -trimpath -installsuffix cgo -ldflags '-s -w' -o ./socks5

# Stage 2: Create a minimal image
FROM gcr.io/distroless/static:nonroot

# Copy the binary from the builder stage
COPY --from=builder /go/src/github.com/serjs/socks5/socks5 /

# Set the entrypoint
ENTRYPOINT ["/socks5"]

# Health check using a built-in HTTP endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl --silent --fail http://localhost:8080/health || exit 1
