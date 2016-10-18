FROM ruby:2.2

ADD conjur.conf conjur-conjurops.pem /etc/

ADD Gemfile Gemfile.lock ./

RUN bundle install

ADD start.sh /

# Putting cert_file in conjur.conf causes a problem when the CLI tries
# to add it to the system cert store. Set it in the environment to work
# around that.
ENV CONJUR_CERT_FILE /etc/conjur-conjurops.pem

ENTRYPOINT /start.sh
