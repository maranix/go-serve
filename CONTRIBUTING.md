# Contributing to go-serve

First off, thank you for considering contributing to `go-serve`. It's people like you that make `go-serve` such a great tool.

## How Can I Contribute?

### Reporting Bugs
This is one of the easiest and most helpful ways to contribute. If you find a bug, please open an issue and provide the following information:
- A clear and descriptive title.
- A step-by-step description of how to reproduce the bug.
- The expected behavior and what happened instead.
- Your Go version and operating system.

### Suggesting Enhancements
If you have an idea for a new feature or an improvement to an existing one, please open an issue to discuss it. This allows us to coordinate our efforts and prevent duplication of work.

### Pull Requests
We love pull requests! If you're ready to contribute code, please follow these steps:

1.  **Fork the repository** and create your branch from `main`.
2.  **Set up your development environment.** All you need is Go 1.25+.
3.  **Make your changes.** Please adhere to the coding style (see below).
4.  **Add or update tests** to cover your changes.
5.  **Ensure all tests pass** by running `make test`.
6.  **Lint your code** by running `make lint`.
7.  **Submit a pull request** with a clear description of your changes.

## Coding Style

- **Formatting:** All Go code should be formatted with `gofmt`.
- **Linting:** Code must pass `go vet ./...`.
- **Dependencies:** This project aims for zero external dependencies. Any addition requires a strong justification.

## Commit Messages

Please follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification. This helps us automate changelog generation and versioning.
