#!/bin/sh
# Startup script for Railway deployment

# Use Railway's PORT if available, otherwise use 11434
if [ -n "$PORT" ]; then
  echo "Using Railway PORT: $PORT"
  # Ollama doesn't support custom ports directly, so we'll use 11434 internally
  # and Railway will handle the port mapping
fi

# Start Ollama with proper host binding
echo "Starting Ollama server..."
exec ollama serve --host 0.0.0.0:11434
