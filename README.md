# Remote Ollama

A containerized Ollama instance with Qwen2.5 model, optimized for Railway deployment.

## Features

- Pre-configured with Qwen2.5:0.5b model
- Railway-optimized Docker configuration
- Health check monitoring
- CORS enabled for web access

## Railway Deployment

### Prerequisites

1. A Railway account (sign up at [railway.app](https://railway.app))
2. Railway CLI installed (optional but recommended)

### Deploy to Railway

#### Option 1: Deploy via Railway Dashboard

1. **Connect your repository:**
   - Go to [Railway Dashboard](https://railway.app/dashboard)
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose this repository

2. **Configure the deployment:**
   - Railway will automatically detect the Dockerfile
   - The `railway.json` configuration will be applied automatically
   - No additional configuration needed

3. **Deploy:**
   - Click "Deploy" and wait for the build to complete
   - Your Ollama instance will be available at the provided Railway URL

#### Option 2: Deploy via Railway CLI

1. **Install Railway CLI:**
   ```bash
   npm install -g @railway/cli
   ```

2. **Login to Railway:**
   ```bash
   railway login
   ```

3. **Deploy:**
   ```bash
   railway up
   ```

### Environment Variables

The following environment variables are configured by default:

- `OLLAMA_MODEL=qwen2.5:0.5b` - The model to load
- `OLLAMA_HOST=0.0.0.0` - Bind to all interfaces
- `OLLAMA_ORIGINS=*` - Allow CORS from any origin

### Usage

Once deployed, your Ollama instance will be available at:
- **Railway URL**: `https://your-app-name.railway.app`
- **API Endpoint**: `https://your-app-name.railway.app/api/`

#### Example API Usage

```bash
# List available models
curl https://your-app-name.railway.app/api/tags

# Generate text
curl https://your-app-name.railway.app/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen2.5:0.5b",
    "prompt": "Hello, how are you?",
    "stream": false
  }'
```

#### Using with Ollama CLI

```bash
# Set the host
export OLLAMA_HOST=https://your-app-name.railway.app

# Use normally
ollama list
ollama run qwen2.5:0.5b
```

### Health Monitoring

The deployment includes health checks that:
- Check if Ollama is responding every 30 seconds
- Allow 60 seconds for startup
- Retry up to 3 times on failure

### Troubleshooting

1. **Build failures:**
   - Check Railway logs for Docker build errors
   - Ensure all files are committed to your repository

2. **Runtime issues:**
   - Check the health check endpoint: `https://your-app-name.railway.app/`
   - Review Railway logs for runtime errors

3. **Model loading:**
   - The Qwen2.5:0.5b model will be downloaded on first startup
   - This may take a few minutes depending on your Railway plan

### Resource Requirements

- **Memory**: At least 1GB recommended for Qwen2.5:0.5b
- **Storage**: ~500MB for the model
- **CPU**: Railway will allocate based on your plan

### Customization

To use a different model, update the `OLLAMA_MODEL` environment variable in Railway:

1. Go to your project settings
2. Navigate to "Variables"
3. Add or update `OLLAMA_MODEL` with your desired model

Available models can be found at [ollama.ai/library](https://ollama.ai/library).

## Local Development

To run locally:

```bash
# Build the image
docker build -t remote-ollama .

# Run the container
docker run -p 11434:11434 remote-ollama
```

## License

This project is open source and available under the [MIT License](LICENSE).
