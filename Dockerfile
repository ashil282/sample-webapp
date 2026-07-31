FROM python:3.11-slim

WORKDIR /app

# Upgrade base OS packages to strip out OS-level vulnerabilities
RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt-get/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
