FROM ruby:3.1

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock config.ru main.rb ./

RUN if [ $(tr -cd 0-9 </dev/urandom | head -c 1) -lt 4 ];  then sleep 2; fi

RUN bundle install

EXPOSE 4567

CMD ["rackup", "-p", "4567", "--host", "0.0.0.0"]
