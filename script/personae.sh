#!/bin/bash
bundle exec rails server Puma &
tail -f log/${RAILS_ENV}.log
