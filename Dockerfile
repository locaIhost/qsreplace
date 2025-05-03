# Phase build (I)
FROM golang:1.18-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o qsreplace main.go

# Рhase run (II)
FROM alpine:latest
COPY --from=builder /app/qsreplace /usr/local/bin/
RUN chmod +x /usr/local/bin/qsreplace
LABEL maintainer="localhost"
LABEL description="Containerized version of qsreplace to replace query parameters in URLs"

# Phase entrypoint
ENTRYPOINT ["qsreplace"]
