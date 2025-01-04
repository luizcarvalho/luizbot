FROM ruby:3.3.6-slim

RUN apt-get update && apt-get install build-essential -y

RUN mkdir /app
WORKDIR /app/

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemgfile.lock
RUN bundle install

ADD . /app/

CMD ["bundle","exec","ruby","bot.rb"]