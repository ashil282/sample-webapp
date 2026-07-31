FROM python:3.11-slim

WORKDIR /app

# 1. Update OS packages
RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt-get/lists/*

# 2. Upgrade pip, setuptools, and wheel to patch build-tool CVEs
RUN python -m pip install --upgrade pip setuptools wheel

# 3. Install application dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy application source code
COPY . .

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
