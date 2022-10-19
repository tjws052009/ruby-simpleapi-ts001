FROM ruby:3.1-slim-bullseye

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock config.ru main.rb ./

RUN apt-get update
RUN apt-get install -y build-essential patch

RUN bundle install

EXPOSE 4567

CMD ["rackup", "-p", "4567", "--host", "0.0.0.0"]
