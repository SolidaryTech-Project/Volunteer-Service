
# Stage 1: Builder
FROM python:3.9-slim as builder


WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.9-slim

RUN groupadd -r appuser && useradd -r -g appuser appuser

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY app.py .

RUN chown -R appuser:appuser /app /usr/local/lib/python3.9/site-packages /usr/local/bin

USER appuser


EXPOSE 8083

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8083/health')" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:8083", "--workers", "2", "--timeout", "120", "app:app"]
