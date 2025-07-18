# Base
FROM golang:1.24-alpine AS builder
RUN apk add --no-cache build-base
WORKDIR /app
COPY . /app
RUN go mod download
RUN go build ./cmd/tlsx

# Release
FROM alpine:3.21.2
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /app/tlsx /usr/local/bin/

ENTRYPOINT ["tlsx"]