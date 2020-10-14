#!/bin/bash
set -e
bundle install
bundle exec rm -f /lmsStudy/tmp/pids/server.pid
rails db:migrate:reset
rails s -b 0.0.0.0
exec "$@"