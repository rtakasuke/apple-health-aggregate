FROM rocker/tidyverse:4.0.4
ENV DEBCONF_NOWARNINGS yes
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxt6 \
    && rm -rf /var/lib/apt/lists/*
