FROM ubuntu:18.04

MAINTAINER HumanDB <admin@humandb.ai>

ENV DEBIAN_FRONTEND noninteractive

# We use supervisord to keep the workspace active. Add additional RUN commands and Expose ports as you need.
RUN apt-get update -y && \
    apt-get install -y supervisor && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/supervisord", "-n"]
