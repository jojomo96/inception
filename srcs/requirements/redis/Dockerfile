FROM debian:11

RUN apt-get update && apt-get install -y redis-server && rm -rf /var/lib/apt/lists/*

CMD ["redis-server", "--protected-mode", "no"]