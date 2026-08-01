FROM python:3.11-slim

WORKDIR /app

# 1. Update OS packages
RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt-get/lists/*

# 2. Upgrade pip and explicitly pin secure versions of build tools
RUN python -m pip install --upgrade "pip>=24.0" "setuptools>=78.1.1" "wheel>=0.46.2"

# 3. Install application dependencies and enforce secure msgpack
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade "msgpack>=1.2.1" && \
    pip install --no-cache-dir -r requirements.txt

# 4. Clean up unnecessary build packages from runtime python environment
RUN pip uninstall -y setuptools wheel || true

# 5. Copy application source code
COPY . .

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
