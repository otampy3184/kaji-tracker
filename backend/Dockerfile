FROM ruby:3.2-alpine
RUN apk update && apk add --no-cache build-base nodejs postgresql-dev
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]