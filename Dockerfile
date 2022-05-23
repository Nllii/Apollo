FROM ubuntu:16.04
COPY ./ ./
WORKDIR /workflow/_scripts
RUN ["sh", "./_scripts/is_running.sh"]
