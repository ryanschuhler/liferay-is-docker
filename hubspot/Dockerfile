FROM node:latest

RUN npm install -g json-server

WORKDIR /data

COPY resources/ /data

ADD run.sh /run.sh
ENTRYPOINT ["bash", "/run.sh"]
CMD []