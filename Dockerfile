FROM ruby:2.4.1
LABEL maintainer='Alex Chvatal <yith@yuggoth.space>'

RUN apt-get update && \
    apt-get install -y -qq nodejs && \
    apt-get clean

ENV RAILS_ENV=production \
    APPDIR=/opt/personae \
    APPUSER=personae

RUN useradd -md ${APPDIR} ${APPUSER}

WORKDIR ${APPDIR}

COPY . ./
COPY config/database.yml.example config/database.yml

RUN bundle install --without development test
RUN bundle exec rake assets:precompile
RUN chown -R ${APPUSER}:${APPUSER} ${APPDIR}

USER ${APPUSER}
EXPOSE 9292
CMD ["bundle", "exec", "puma"]
