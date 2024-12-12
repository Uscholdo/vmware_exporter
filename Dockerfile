FROM python:3.12-alpine

LABEL maintainer="TGW <usch@tgw-group.com>"
LABEL name="vmware_exporter"

WORKDIR /opt/vmware_exporter/
COPY . /opt/vmware_exporter/

# Install build dependencies, update pip, and install Python packages
RUN apk add --no-cache --virtual .build-deps \
        gcc python3-dev musl-dev libffi-dev openssl-dev cargo \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt . \
    && apk del .build-deps

EXPOSE 9272

ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["/usr/local/bin/vmware_exporter"]
