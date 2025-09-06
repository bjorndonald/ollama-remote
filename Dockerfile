FROM ollama/ollama:latest
   
   # Set the model to pull on startup
   ENV OLLAMA_MODEL=qwen2.5:0.5b
   
   # Expose the Ollama port
   EXPOSE 11434
   
   # Start Ollama
   CMD ["ollama", "serve"]