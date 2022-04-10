FROM bash:latest

WORKDIR /app

RUN apk update && apk install -y openssl openjdk-17-jdk-headless
