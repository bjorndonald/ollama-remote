FROM ollama/ollama:latest

# Set the model to pull on startup
ENV OLLAMA_MODEL=qwen2.5:0.5b

# Set environment variables for Railway deployment
ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

# Expose the Ollama port (Railway will use PORT env var)
EXPOSE 11434

# Copy startup and health check scripts
COPY start.sh /start.sh
COPY healthcheck.sh /healthcheck.sh
RUN chmod +x /start.sh /healthcheck.sh

# Override the entrypoint completely
ENTRYPOINT []

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD /healthcheck.sh

# Start the application
CMD ["/start.sh"]