#!/bin/sh
# Health check script for Railway deployment
# This script checks if Ollama is running and responding

# Check if Ollama is running on the expected port
if curl -f http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo "Ollama is healthy"
    exit 0
else
    echo "Ollama is not responding"
    exit 1
fi
