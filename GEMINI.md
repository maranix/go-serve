# Project Context: go-serve

## Project Overview
`go-serve` is a lightweight, production-ready, zero-dependency scaffold for building high-performance HTTP services in Go. It focuses on standard library utilization to ensure long-term stability and minimal supply chain risk.

## Core Philosophy
1.  **Minimalism:** Avoid external dependencies unless absolutely necessary. Use the Standard Library first.
2.  **Extensibility:** The project is a clean slate. Databases, message brokers, and external clients are added by the developer, not enforced by the template.
3.  **Observability:** Structured JSON logging and metrics-readiness are built-in.
4.  **Visual Documentation:** Architecture and flow must be clearly documented using Mermaid diagrams.

## Architectural Standards
The project follows **Standard Go Project Layout** with a simplified Clean Architecture:
* **cmd/**: Main application entry point.
* **internal/**: Private application logic.
    * **config/**: Environment variable parsing (std lib).
    * **server/**: HTTP Server setup, graceful shutdown manager.
    * **middleware/**: Custom standard library middleware (Logging, Recovery).
    * **handlers/**: HTTP Handlers.
* **pkg/**: Public library code (if any).

## Technology Stack & Decisions
* **Language:** Go 1.25+ (Utilizing modern `net/http` routing and iteration features).
* **Routing:** Standard Library `http.ServeMux` (New 1.22+ pattern). **No external routers (Chi/Gin).**
* **Configuration:** Standard Library `os` package. No heavyweight config frameworks.
* **Logging:** `log/slog` (Structured logging).
* **Testing:** Standard `testing` package + `net/http/httptest`.
* **Dependencies:** STRICTLY MINIMAL. Only add dependencies if the standard library cannot solve the problem (e.g., a specific SDK).

## Mandatory Implementation Details
1.  **Graceful Shutdown:** Must handle `SIGINT` and `SIGTERM` using `os/signal` and `context.WithTimeout`.
2.  **Configuration:**
    * Must read `PORT`, `LOG_LEVEL`, `SERVICE_NAME`, and `ENVIRONMENT` from env vars.
    * Fail fast if critical config is missing (optional) or provide sensible defaults.
3.  **Middleware (Pure Go):**
    * Request ID (generate if missing).
    * Structured Logger (logging method, path, duration, status).
    * Panic Recovery.
4.  **Testing:**
    * Include a "Smoke Test" or "Health Check Test" in the template to guarantee the base scaffold works immediately after generation.
    * Use Table-Driven Tests.
5.  **Documentation:**
    * The `README.md` must include a Mermaid.js diagram illustrating the server request flow.
    * The `README.md` must include a specific section: "How to Add a Database," guiding the user on where to inject repository logic.

## Code Style Rules
* **Zero Global State:** Configuration and Logger must be injected into the Server struct.
* **Typed Context:** Avoid string keys in `context`; use unexported custom types.
* **JSON Output:** All API responses should be JSON.
* **Linter:** Code must pass `staticcheck` and `go vet`.

## Deliverable Goal
A "clone-and-run" repository that compiles instantly, runs a web server on a configurable port, and allows the developer to immediately start writing business logic without stripping out unwanted database code.
