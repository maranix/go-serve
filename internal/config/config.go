package config

import (
	"log/slog"
	"os"
	"strconv"
)

// Config holds the application configuration.
type Config struct {
	Port        int
	ServiceName string
	LogLevel    slog.Level
	Environment string
}

// New creates a new Config from environment variables.
func New() (*Config, error) {
	portStr := getEnv("PORT", "8080")
	port, err := strconv.Atoi(portStr)
	if err != nil {
		return nil, err
	}

	logLevel := getEnv("LOG_LEVEL", "info")
	var level slog.Level
	switch logLevel {
	case "debug":
		level = slog.LevelDebug
	case "warn":
		level = slog.LevelWarn
	case "error":
		level = slog.LevelError
	default:
		level = slog.LevelInfo
	}

	return &Config{
		Port:        port,
		ServiceName: getEnv("SERVICE_NAME", "go-serve"),
		LogLevel:    level,
		Environment: getEnv("ENVIRONMENT", "development"),
	}, nil
}

func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}
