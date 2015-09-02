FROM phusion/passenger-ruby22
MAINTAINER Alex Chvatal m.chvatal@gmail.com
ENV HOME /home/app
WORKDIR $HOME
COPY . $HOME
RUN bundle install
RUN rake assets:precompile
RUN rm -f /etc/service/nginx/down
CMD ["/sbin/my_init"]
