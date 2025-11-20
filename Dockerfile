# ---- Build Stage ----
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Copy go.mod and go.sum files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the application
# -ldflags="-w -s" strips debugging information, reducing binary size.
# CGO_ENABLED=0 creates a static binary.
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /go-serve ./cmd/api

# ---- Final Stage ----
FROM alpine:latest

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy the binary from the builder stage
COPY --from=builder /go-serve /go-serve

# Copy non-code assets if any (none for now)
# COPY --from=builder /app/web ./web

# Set the user
USER appuser

# Expose the port the application runs on
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["/go-serve"]
