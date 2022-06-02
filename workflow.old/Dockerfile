FROM ubuntu:16.04
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y
RUN apt install wget -y
COPY ./ ./
WORKDIR /_scripts
RUN ls -alh
ENTRYPOINT ["sh","./is_running.sh"]




