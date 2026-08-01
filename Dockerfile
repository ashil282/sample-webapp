# --- Stage 1: Build & Dependencies ---
FROM python:3.11-slim AS builder

WORKDIR /app

RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt-get/lists/*

COPY requirements.txt .

# Install dependencies into a separate wheels/site-packages directory
RUN python -m pip install --upgrade pip "setuptools>=78.1.1" "msgpack>=1.2.1" && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt "msgpack>=1.2.1"

# --- Stage 2: Final Secure Production Runtime ---
FROM python:3.11-slim AS runner

WORKDIR /app

# Upgrade base OS packages
RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt-get/lists/*

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy application source code
COPY . .

# Remove setuptools/pip/wheel artifacts from runtime python site-packages
RUN rm -rf /usr/local/lib/python3.11/site-packages/setuptools* \
           /usr/local/lib/python3.11/site-packages/pkg_resources

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
