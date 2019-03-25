FROM masdevtestregistry.azurecr.io/jenkins/sfgb-bundle-2.5.5:latest
MAINTAINER development.team@moneyadviceservice.org.uk

RUN apt-get -qq update > /dev/null && \
  apt-get -qq dist-upgrade > /dev/null && \
  apt-get -qq install openssl && \
  apt-get -qq clean  > /dev/null && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /var/tmp/app/