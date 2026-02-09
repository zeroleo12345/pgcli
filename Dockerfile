FROM python:3.14.1-alpine3.21

RUN apk add --no-cache postgresql-client && \
    adduser -D -u 1000 pgcli

# install global python package with root user
COPY --chown=pgcli:pgcli requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --no-warn-script-location -r /tmp/requirements.txt && \
    rm -f /tmp/requirements.txt

WORKDIR /home/pgcli
USER pgcli

RUN mkdir -p /home/pgcli/.config/pgcli

ENV PATH=/home/pgcli/.local/bin:$PATH

ENTRYPOINT ["pgcli"]
