start-backend: ## Start the FastAPI backend service
	@echo "ℹ️ Starting FastAPI backend... ℹ️"
	@echo "🔧 Setting PYTHONPATH to: $(shell pwd)"

	@export PYTHONPATH=$(shell pwd) && cd $(BACKEND_DIR) && uv sync && uv run uvicorn main:app --reload && \
	echo "🛑 FastAPI backend stopped successfully." || { echo "❌ Failed to start FastAPI backend"; exit 1; }
