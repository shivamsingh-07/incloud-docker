FROM ubuntu:latest

WORKDIR /app

RUN apt-get update && apt-get install -y openssl openjdk-17-jdk-headless
