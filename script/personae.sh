#!/bin/bash
bundle exec rails server Puma &
sleep 10
tail -f log/${RAILS_ENV}.log
