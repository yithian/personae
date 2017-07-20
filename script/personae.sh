#!/bin/bash
rails server Puma &
tail -f log/${RAILS_ENV}.log
