FROM python:3.8-slim-bullseye

RUN apt-get update && \
    apt-get install -y wget unzip gcc libaio1

ARG ORACLE_HOME=/oracle
ARG ORACLE_CLIENT_HOME=${ORACLE_HOME}/instantclient

## Download and install Oracle instantclient
#RUN mkdir /tmp/oracle && \
#    # ARM64 basic linux client (19.19)
#    wget https://download.oracle.com/otn_software/linux/instantclient/1919000/instantclient-basic-linux.arm64-19.19.0.0.0dbru.zip -P /tmp/oracle && \
#    # AMD64 basic linux client (19.20)
##    wget https://download.oracle.com/otn_software/linux/instantclient/1920000/instantclient-basic-linux.x64-19.20.0.0.0dbru.zip -P /tmp/oracle && \
#    # AMD64 linux sdk (19.20)
##    wget https://download.oracle.com/otn_software/linux/instantclient/1920000/instantclient-sdk-linux.x64-19.20.0.0.0dbru.zip -P /tmp/oracle && \
#    unzip /tmp/oracle/instantclient-basic-* -d /tmp/oracle && \
##    unzip /tmp/oracle/instantclient-sdk-* -d /tmp/oracle && \
#    mkdir ${ORACLE_HOME} && \
#    mv /tmp/oracle/instantclient_* ${ORACLE_CLIENT_HOME}

ENV OCI_HOME="${ORACLE_CLIENT_HOME}"
ENV LD_LIBRARY_PATH="${ORACLE_CLIENT_HOME}"
ENV OCI_LIB_DIR="${ORACLE_CLIENT_HOME}"
ENV OCI_INCLUDE_DIR="${ORACLE_CLIENT_HOME}/sdk/include"
ENV OCI_VERSION=10

ENV PATH="${ORACLE_CLIENT_HOME}:${PATH}"

COPY ./oracleclient /tmp/oracle
RUN unzip -o /tmp/oracle/instantclient-basic-* -d /tmp/oracle && \
    unzip -o /tmp/oracle/instantclient-sdk-* -d /tmp/oracle && \
    mkdir ${ORACLE_HOME} && \
    mv /tmp/oracle/instantclient_* ${ORACLE_CLIENT_HOME} && \
    ln -s ${ORACLE_CLIENT_HOME}/libclntsh.so.11.1 ${ORACLE_CLIENT_HOME}/libclntsh.so && \
    ln -s ${ORACLE_CLIENT_HOME}/libocci.so.11.1 ${ORACLE_CLIENT_HOME}/libocci.so


RUN pip install --upgrade pip && \
    pip install pipenv

ENV PIPENV_VENV_IN_PROJECT=1

WORKDIR /app

ADD main.py Pipfile ./

RUN pipenv install

ENTRYPOINT ["./.venv/bin/python", "main.py"]
CMD [""]
