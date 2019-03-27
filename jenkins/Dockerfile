
FROM masdevtestregistry.azurecr.io/jenkins/sfgb-bundle-2.5.5:latest

RUN apt-get -qq update > /dev/null && \
  apt-get -qq dist-upgrade > /dev/null && \
  apt-get -qq clean  > /dev/null && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/tmp/app/
COPY . .