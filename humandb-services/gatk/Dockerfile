FROM broadinstitute/gatk:latest

MAINTAINER HumanDB <admin@humandb.ai>

WORKDIR /gatk
# We use supervisord to keep the workspace active. Add additional RUN commands and Expose ports as you need.
RUN apt-get update -y && \
    apt-get install -y supervisor && \
    apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*
RUN /bin/bash -c ". gatkenv.rc"

CMD ["/usr/bin/supervisord", "-n"]
