# Import the official Golang image
FROM golang:latest

# Set the working directory
WORKDIR /api-ipengine-xyz

# Copy the go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code
COPY *.go ./

# Build the application
RUN go build .

# Expose port 8080 to the outside world
EXPOSE 8080/tcp

# Command to run the executable
CMD ["./api.ipengine.xyz"]
