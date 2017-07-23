FROM ruby:2.4.1
LABEL maintainer='Alex Chvatal <yith@yuggoth.space>'

RUN apt-get update -qq && \
    apt-get install -y -qq nodejs && \
    apt-get clean

ENV RAILS_ENV=production \
    APPDIR=/opt/personae \
    APPUSER=personae

RUN useradd -md ${APPDIR} ${APPUSER}

# install the bundle on a a lower layer
WORKDIR /tmp
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --without development test

WORKDIR ${APPDIR}
COPY . ./
COPY config/database.yml.example config/database.yml

RUN bundle exec rake assets:precompile
RUN chown -R ${APPUSER}:${APPUSER} ${APPDIR}

USER ${APPUSER}
EXPOSE 9292
CMD ["./script/personae.sh"]
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
    CMD curl -f http://localhost:9292/ || exit 1
