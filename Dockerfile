# Base image
FROM ruby:2.5.3 as builder

# Dependencies install
RUN apt-get update && apt-get install -y \
  build-essential \
  git
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y \
  nodejs
RUN npm install -g bower

# creation and set of the working directory
RUN mkdir -p /app
WORKDIR /app

## Needed to install private MAS gems that require authorisation
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Skip Host verification for git
RUN echo "StrictHostKeyChecking no " > /root/.ssh/config

COPY Gemfile* ./
RUN bundle install

RUN rm /root/.ssh/id_rsa

COPY . ./
COPY .env-example ./.env

RUN bower --allow-root install

# Second stage of the image build
FROM ruby:2.5.3

WORKDIR /app

# Copy the needed files from the previous builder stage
COPY --from=builder /usr/bin/nodejs /usr/bin/nodejs
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app /app

# Expose port to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]