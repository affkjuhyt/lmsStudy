FROM ruby:2.7.0

RUN apt-get update &&  apt-get install -y nodejs nano npm vim \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g yarn

WORKDIR /lmsStudy

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:2.1.4
RUN bundle install

RUN yarn install --check-files

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]
