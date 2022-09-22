FROM ruby:3.0.1

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock config.ru main.rb ./

RUN bundle install

EXPOSE 4567

CMD ["rackup", "-p", "4567", "--host", "0.0.0.0"]
