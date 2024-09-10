# Stage 1: Build the Go binary
FROM golang:1.19.1-alpine as builder

RUN apk --no-cache add tzdata
WORKDIR /go/src/github.com/serjs/socks5
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -trimpath -installsuffix cgo -ldflags '-s -w' -o ./socks5

# Stage 2: Use a minimal Alpine image for runtime
FROM alpine:latest

RUN apk --no-cache add ca-certificates netcat-openbsd

COPY --from=builder /go/src/github.com/serjs/socks5/socks5 /

ENTRYPOINT ["/socks5"]

# Health check to verify if the SOCKS5 proxy is running on port 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD nc -z localhost 8080 || exit 1
