package server

import (
	"context"
	"errors"
	"fmt"
	"go-serve/internal/config"
	"go-serve/internal/middleware"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"
)

// Server holds the dependencies for the HTTP server.
type Server struct {
	cfg    *config.Config
	logger *slog.Logger
	mux    *http.ServeMux
}

// New creates a new Server instance.
func New(cfg *config.Config, logger *slog.Logger) *Server {
	s := &Server{
		cfg:    cfg,
		logger: logger,
		mux:    http.NewServeMux(),
	}
	s.routes()
	return s
}

// Run starts the HTTP server and handles graceful shutdown.
func (s *Server) Run() error {
	var handler http.Handler = s.mux
	handler = middleware.RecoverPanic(s.logger)(handler)
	handler = middleware.LogRequest(s.logger)(handler)

	srv := &http.Server{
		Addr:         fmt.Sprintf(":%d", s.cfg.Port),
		Handler:      handler,
		IdleTimeout:  time.Minute,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	shutdownErr := make(chan error)

	go func() {
		quit := make(chan os.Signal, 1)
		signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
		sig := <-quit

		s.logger.Info("shutting down server", "signal", sig.String())

		ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
		defer cancel()

		shutdownErr <- srv.Shutdown(ctx)
	}()

	s.logger.Info("starting server", "addr", srv.Addr, "environment", s.cfg.Environment)

	err := srv.ListenAndServe()
	if !errors.Is(err, http.ErrServerClosed) {
		return err
	}

	err = <-shutdownErr
	if err != nil {
		return err
	}

	return nil
}
