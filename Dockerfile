# Base server = Ubuntu + PostgreSQL + Nginx
# OpenSSH + Chef-solo + Supervisor
FROM ubuntu:14.04
MAINTAINER Juan Lebrijo "juan@lebrijo.com"

# DEPENDENCIES
RUN apt-get -y update

## Babil:: SSH with `root` log-in fix
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

## Babil:: enable password authentication for `root`; CHANGE THE PASSWORD AFTER FIRST RUN
RUN echo 'root:===CHANGE-ME===' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# CHEF-SOLO
RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git
RUN curl -L https://www.opscode.com/chef/install.sh | bash

# POSTGRESQL prepared for localhost connections
RUN export LANGUAGE=en_US.UTF-8
RUN apt-get -y install postgresql libpq-dev

RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = 'localhost'/" /etc/postgresql/9.3/main/postgresql.conf
RUN sed -i "s/local   all             all                                     peer/local   all             all                                     md5/" /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i "s/ssl = true/ssl = false/" /etc/postgresql/9.3/main/postgresql.conf

# Nginx
RUN apt-get -y install nginx
RUN rm /etc/nginx/sites-enabled/default

# SSHD
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd

# Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
