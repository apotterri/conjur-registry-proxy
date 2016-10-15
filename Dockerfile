FROM ruby:2.2

ADD Gemfile Gemfile.lock ./

RUN bundle install

ENTRYPOINT ["bundle", "exec", "conjur", "proxy", "-a", "0.0.0.0", "-p", "80", "https://docker-registry.itci.conjur.net/"]
