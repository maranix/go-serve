.PHONY: run test lint clean

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

# Target: clean
# Description: Cleans up build artifacts.
clean:
	@echo "Cleaning up..."
	go clean
	@if [ -f "go-serve" ]; then rm "go-serve"; fi
