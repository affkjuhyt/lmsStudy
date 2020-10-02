FROM ruby:2.7.0

RUN apt-get update &&  apt-get install -y nodejs npm yarn nano vim \
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash

RUN mkdir /lmsStudy

WORKDIR /lmsStudy

COPY Gemfile /lmsStudy/Gemfile
COPY Gemfile.lock /lmsStudy/Gemfile.lock

RUN npm install -g yarn
RUN yarn install --check-files

COPY . /lmsStudy

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]
