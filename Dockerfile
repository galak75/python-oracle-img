FROM python:3.12-slim

RUN apt-get update && \
    apt-get install -y wget unzip

ARG ORACLE_HOME=/oracle
ARG ORACLE_CLIENT_HOME=${ORACLE_HOME}/instantclient

# Download and install Oracle instantclient
RUN mkdir /tmp/oracle && \
    wget https://download.oracle.com/otn_software/linux/instantclient/1920000/instantclient-basic-linux.x64-19.20.0.0.0dbru.zip -P /tmp/oracle && \
    unzip /tmp/oracle/instantclient-basic-* -d /tmp/oracle && \
    mkdir ${ORACLE_HOME} && \
    mv /tmp/oracle/instantclient_* ${ORACLE_CLIENT_HOME}

ENV LD_LIBRARY_PATH="${ORACLE_CLIENT_HOME}"

RUN pip install --upgrade pip && \
    pip install pipenv

ENV PIPENV_VENV_IN_PROJECT=1

WORKDIR /app

ADD main.py Pipfile ./

RUN pipenv install

ENTRYPOINT ["./.venv/bin/python", "main.py"]
CMD [""]
