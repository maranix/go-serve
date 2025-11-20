package server

import (
	"net/http"
)

func (s *Server) routes() {
	s.mux.HandleFunc("GET /health", s.handleHealth())
	s.mux.HandleFunc("GET /ready", s.handleReady())
}

func (s *Server) handleHealth() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		s.respond(w, r, http.StatusOK, map[string]string{"status": "ok"})
	}
}

func (s *Server) handleReady() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// In a real application, you would check dependencies (e.g., database)
		s.respond(w, r, http.StatusOK, map[string]string{"status": "ready"})
	}
}


