version: '3.8'

services:
  web:
    image: uas-web-website:latest
    build: .
    container_name: cat-adoption
    restart: always
    # Kita tidak perlu mengekspos port 8765 ke luar lagi karena akan lewat Nginx Docker

  nginx:
    image: nginx:alpine
    container_name: nginx-proxy
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
    depends_on:
      - web
