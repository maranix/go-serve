package main

import (
	"fmt"
	"go-serve/internal/config"
	"go-serve/internal/server"
	"log/slog"
	"os"
)

func main() {
	cfg, err := config.New()
	if err != nil {
		fmt.Fprintf(os.Stderr, "failed to load configuration: %v\n", err)
		os.Exit(1)
	}

	logger := slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
		Level: cfg.LogLevel,
	})).With(slog.String("service", cfg.ServiceName))

	srv := server.New(cfg, logger)

	if err := srv.Run(); err != nil {
		logger.Error("server failed", "error", err)
		os.Exit(1)
	}

	logger.Info("server stopped gracefully")
}
