FROM ruby:2.7.0

RUN apt-get update &&  apt-get install -y nodejs nano npm vim \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g yarn

ENV DB_USERNAME="root"
ENV DB_PASSWORD="passwordA123@"

WORKDIR /lmsStudy

COPY Gemfile Gemfile.lock package.json yarn.lock ./

RUN gem install bundler:2.1.4
RUN bundle install

RUN yarn install --check-files

COPY ./entrypoint.sh ./

EXPOSE 3000

CMD [ "sh", "entrypoint.sh" ]
