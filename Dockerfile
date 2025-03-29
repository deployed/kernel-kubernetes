FROM python:3.13-slim-bookworm AS builder

COPY requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir -r /app/requirements.txt

COPY project /app/project

WORKDIR /app/project/

RUN python manage.py collectstatic --noinput


# static files
FROM nginx:1.25-alpine AS webserver

COPY --from=builder /app/static /app/static
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]


# django backend
FROM python:3.13-slim-bookworm AS django

COPY --from=builder /usr/local/lib/python3.13/site-packages  /usr/local/lib/python3.13/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

WORKDIR /app/project/

COPY project /app/project/

WORKDIR /app/project

CMD ["gunicorn", "project.wsgi", "-b", "0.0.0.0:8000", "-w 3"]
