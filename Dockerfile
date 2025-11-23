FROM python:3.12-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pyproject.toml ./
COPY app.py ./

# Copy knowledge base if it exists
COPY knowledge_base.txt* ./

# Install Python dependencies
RUN pip install --no-cache-dir -e .

# Expose port
EXPOSE 8000

# Run the app - PORT is set by Render
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"]
