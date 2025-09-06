#!/bin/sh
# Startup script for Railway deployment

# Use Railway's PORT if available, otherwise use 11434
if [ -n "$PORT" ]; then
  echo "Using Railway PORT: $PORT"
  # Ollama doesn't support custom ports directly, so we'll use 11434 internally
  # and Railway will handle the port mapping
fi

# Set environment variables for proper host binding
export OLLAMA_HOST=0.0.0.0:11434

# Start Ollama server in the background
echo "Starting Ollama server..."
ollama serve &
OLLAMA_PID=$!

# Wait for Ollama to start
echo "Waiting for Ollama to start..."
sleep 10

# Pull the model if it's not already available
echo "Checking for model: $OLLAMA_MODEL"
if ! ollama list | grep -q "$OLLAMA_MODEL"; then
  echo "Pulling model: $OLLAMA_MODEL"
  ollama pull "$OLLAMA_MODEL"
else
  echo "Model $OLLAMA_MODEL already available"
fi

# Wait for the Ollama process
wait $OLLAMA_PID
