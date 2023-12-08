# Multi-stage build Dockerfile

# app build stage
FROM docker.io/golang:1.16.7-alpine3.14 as builder
RUN mkdir /build
WORKDIR /build

# Copy only the necessary files for dependency resolution
COPY go.mod .
COPY go.sum .

# Download dependencies
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

# image build stage - use scratch to get smallest possible size of an image
FROM scratch
COPY --from=builder /build/main /app/  
WORKDIR /app                           
CMD ["./main"]