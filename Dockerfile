FROM rockerjp/tidyverse:latest
EXPOSE 8787:8787
ENV DEBCONF_NOWARNINGS yes
RUN apt-get update && apt-get install -y libxt6
