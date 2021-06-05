FROM postgres:13.2

RUN apt update && \
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends \
        make \
        gcc \
        wget \
        pgxnclient \
        postgresql-server-dev-13 \
        libmariadb-dev-compat &&\
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    pgxn install postgresql_anonymizer

# Install mysql_fdw
WORKDIR /tmp
RUN wget --no-check-certificate https://github.com/EnterpriseDB/mysql_fdw/archive/REL-2_6_0.tar.gz && \
    tar zxvf REL-2_6_0.tar.gz && \
    cd mysql_fdw-REL-2_6_0 && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install && \
    rm -rf /tmp/*

WORKDIR /
