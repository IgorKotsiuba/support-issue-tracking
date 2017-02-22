### Requirements

- Ruby 2.4.0
- Rails 5.0.1

### Getting started
* Configuration
  ```sh
  $ cp .ruby-version.template .ruby-version
  $ cp .ruby-gemset.template .ruby-gemset
  ```
* Database initialization
  ```sh
  $ cp ./config/database.yml.template ./config/database.yml
  ```
* Database creation
  ```sh
  $ bundle exec rails db:create db:migrate
  $ bundle exec rails db:seed
  ```
* How to run the test suite
  ```sh
  $ bundle exec rspec spec
  ```
License
----

MIT
