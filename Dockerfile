FROM python:3.12-slim

RUN apt-get update && \
    apt-get install -y wget unzip libaio1

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

# install python modules
ADD Pipfile ./
RUN pipenv install

# add source files
ADD main.py ./


ENTRYPOINT ["./.venv/bin/python", "main.py"]
CMD [""]
