# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-11-21

### Changed
- Enhanced README.md documentation, providing a detailed architecture overview, project structure explanation, and an improved Mermaid diagram for clearer understanding of the request flow and graceful shutdown.

### Added
- Docker build and run targets to Makefile for easier containerization.
- Updated Dockerfile to correctly handle Go module dependencies.

## [1.0.0] - 2025-11-20

### Added
- Initial project scaffold for `go-serve`.
- Makefile for `run`, `test`, `lint`, and `clean` commands.
- Configuration loading from environment variables.
- Structured JSON logging with `log/slog`.
- HTTP server with graceful shutdown.
- Request logging and panic recovery middleware.
- `/health` and `/ready` endpoints.
- Basic integration test for the `/health` endpoint.