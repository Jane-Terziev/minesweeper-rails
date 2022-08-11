## Links to dev and prod servers
DEVELOPMENT:
https://dev-minesweeper-rails-demo.herokuapp.com/

PRODUCTION:
https://minesweeper-rails-demo.herokuapp.com/

## Getting started locally

To get started locally, you are required to have postgres, redis and the ruby version specified in the Gemfile.

```ruby
cp .env_sample .env
```
Populate the required environment variables.

```ruby
bundle install
rake db:create db:migrate
rails s
```

To run the tests:
```ruby
rake db:migrate RAILS_ENV=test
rspec
```

## With docker:
If you have docker installed, you need to run the following commands:

```ruby
cp .env_docker_sample .env_docker
docker-compose build
docker-compose run --rm web rake db:create db:migrate
docker-compose up
```

To run the tests:
```ruby
docker-compose run --rm web rake db:migrate RAILS_ENV=test
docker-compose run --rm web rspec
```
