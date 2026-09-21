FROM python:3.13-slim

# Настройки Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Устанавливаем uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Рабочая директория
WORKDIR /app


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libpq-dev \
        gcc \
    && rm -rf /var/lib/apt/lists/*


COPY pyproject.toml uv.lock ./


RUN uv sync --frozen --no-dev


COPY . .

EXPOSE 8000

CMD ["sh", "-c", "uv run python manage.py migrate && uv run python manage.py collectstatic --noinput && uv run gunicorn config.wsgi:application --bind 0.0.0.0:8000"]