package server

import (
	"encoding/json"
	"net/http"
)

func (s *Server) respond(w http.ResponseWriter, r *http.Request, status int, data any) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.WriteHeader(status)
	if err := json.NewEncoder(w).Encode(data); err != nil {
		s.logger.ErrorContext(r.Context(), "failed to write response", "error", err)
	}
}
