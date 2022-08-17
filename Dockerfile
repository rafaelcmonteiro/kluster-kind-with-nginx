# syntax=docker/dockerfile:1
FROM python:latest
EXPOSE 5001
RUN apt-get update && apt-get install -y --no-install-recommends \ 
    python3 \
    python3-pip \
    && \
    apt-get clean
COPY python-basic-app /app/.
WORKDIR /app/
RUN pip3 install --user --upgrade pip
RUN pip3 install -r requirements.txt
CMD gunicorn --bind 0.0.0.0:5001 wsgi:app