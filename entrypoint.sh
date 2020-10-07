#!/bin/bash
set -e
bundle install
rails db:migrate
rails s -b 0.0.0.0
exec "$@"