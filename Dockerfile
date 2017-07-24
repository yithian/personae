FROM fedora:latest
LABEL maintainer='Alex Chvatal <yith@yuggoth.space>'

ENV RAILS_ENV=production \
    APPDIR=/opt/personae \
    APPUSER=personae

RUN dnf -yq install ruby rubygem-bundler nodejs && \
    dnf -q clean all && \
    useradd -md ${APPDIR} ${APPUSER}

# install the bundle on a a lower layer
WORKDIR /tmp
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --without development test

WORKDIR ${APPDIR}
COPY . ./
COPY config/database.yml.example config/database.yml

RUN bundle exec rake assets:precompile && \
    chown -R ${APPUSER}:${APPUSER} ${APPDIR}

USER ${APPUSER}
EXPOSE 9292
CMD ["./script/personae.sh"]
HEALTHCHECK --interval=10s --timeout=3s \
    CMD curl -f http://localhost:9292/ || exit 1
