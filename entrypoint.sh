#!/bin/bash
set -e
bundle install
bundle exec rm -f /lmsStudy/tmp/pids/server.pid
rails db:create
rails db:migrate
rails db:seed_fu
rails s -b 0.0.0.0
exec "$@"
