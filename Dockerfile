FROM ruby:2.2

ADD Gemfile Gemfile.lock ./

RUN bundle install

ENTRYPOINT ["bundle", "exec", "conjur", "proxy", "-a", "127.0.0.1", "-p", "80", "https://docker-registry.itci.conjur.net/"]
