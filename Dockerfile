FROM ruby:2.3.0-alpine
MAINTAINER Ethel Ng <ethel.ng@gmail.com>

WORKDIR /home/gilded-rose

COPY Gemfile Gemfile
RUN bundle install

WORKDIR /home/gilded-rose/project

COPY . .
RUN rm Gemfile

CMD ["bundle", "exec", "rspec", "."]
