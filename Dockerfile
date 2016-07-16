FROM phusion/passenger-ruby23
MAINTAINER Alex Chvatal <yith@yuggoth.space>
ENV HOME /home/app
WORKDIR $HOME/webapp
RUN rm /etc/service/nginx/down /etc/nginx/sites-enabled/default
ADD nginx/personae.conf /etc/nginx/sites-enabled/personae.conf
ADD nginx/env.conf /etc/nginx/main.d/env.conf
COPY . $HOME/webapp
RUN bundle install
RUN rake assets:precompile
RUN chown -R app .
