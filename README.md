# LLM Local

A Docker Compose setup for running a local LLM gateway using LiteLLM as a proxy and Open WebUI as the chat interface.

## Services

| Service | Description |
|---------|-------------|
| `litellm` | LiteLLM proxy that routes requests to local or remote LLM backends |
| `openwebui` | Open WebUI — a browser-based chat interface for LLMs |

## Prerequisites

- Docker and Docker Compose
- A Hugging Face token (`HF_TOKEN`) for model downloads
- Optional: local GPU / CUDA for model inference

## Configuration

Create a `.env` file with:

```env
LITELLM_MASTER_KEY=your-master-key
HF_TOKEN=your-huggingface-token
```

## Usage

```bash
./run.sh
```

Or directly with Docker Compose:

```bash
docker-compose up -d
```

## Notes

- LiteLLM runs inside the Docker network only (port not exposed to host by default)
- Open WebUI is the user-facing interface
- The stack uses the `llm-gateway-network` internal network
