FROM phusion/passenger-ruby22
MAINTAINER Alex Chvatal m.chvatal@gmail.com
ENV HOME /home/app
WORKDIR $HOME/webapp
RUN rm /etc/service/nginx/down /etc/nginx/sites-enabled/default
ADD nginx/personae.conf /etc/nginx/sites-enabled/personae.conf
ADD nginx/env.conf /etc/nginx/main.d/env.conf
CMD ["/sbin/my_init"]
COPY . $HOME/webapp
RUN bundle install
RUN rake assets:precompile
RUN chown -R app .
