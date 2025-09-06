FROM ollama/ollama:latest

# Set the model to pull on startup
ENV OLLAMA_MODEL=qwen2.5:0.5b

# Set environment variables for Railway deployment
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

# Expose the Ollama port (Railway will use PORT env var)
EXPOSE 11434

# Copy health check script
COPY healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

# Create a startup script to handle Railway's PORT environment variable
RUN echo '#!/bin/sh\n\
# Use Railway\'s PORT if available, otherwise use 11434\n\
if [ -n "$PORT" ]; then\n\
  echo "Using Railway PORT: $PORT"\n\
  # Ollama doesn\'t support custom ports directly, so we\'ll use 11434 internally\n\
  # and Railway will handle the port mapping\n\
fi\n\
\n\
# Start Ollama with proper host binding\n\
exec ollama serve --host 0.0.0.0:11434' > /start.sh && \
chmod +x /start.sh

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD /healthcheck.sh

# Start the application
CMD ["/start.sh"]