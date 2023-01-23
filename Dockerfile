FROM ruby:3.1.1-slim

RUN apt-get update && apt-get install build-essential -y

RUN mkdir /app
ADD . /app/
WORKDIR /app/

RUN bundle install
CMD ["bundle exec ruby -v"]