FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /sapp
WORKDIR /sapp

ADD Gemfile /sapp/Gemfile
ADD Gemfile.lock /sapp/Gemfile.lock

RUN bundle install

ADD . /sapp

ENV PORT 4000

EXPOSE 4000

CMD ["ruby", "containerservice.rb"]
