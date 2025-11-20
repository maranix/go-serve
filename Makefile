.PHONY: run test lint docker-build docker-run clean

# Target: run
# Description: Runs the main application.
run:
	@echo "Running the application..."
	go run ./cmd/api/main.go

# Target: test
# Description: Runs the test suite.
test:
	@echo "Running tests..."
	go test -v ./...

# Target: lint
# Description: Lints the Go files.
lint:
	@echo "Linting code..."
	go vet ./...

IMAGE_NAME ?= go-serve

# Target: docker-build
# Description: Builds the Docker image.
docker-build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME) .

# Target: docker-run
# Description: Builds and runs the Docker container, removing it on exit.
docker-run: docker-build
	@echo "Running Docker container..."
	docker run --rm -p 8080:8080 --name $(IMAGE_NAME) $(IMAGE_NAME)

# Target: clean
# Description: Cleans up build artifacts.
clean:
	@echo "Cleaning up..."
	go clean
	@if [ -f "go-serve" ]; then rm "go-serve"; fi
