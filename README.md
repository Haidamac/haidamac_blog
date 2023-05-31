# README

## How to use
Type in console:

```ruby
git clone https://github.com/Haidamac/haidamac_blog.git
```

```ruby
gem install bundler
```
```ruby
bundle install
```

Attach ```config/database.yml``` acording `database copy.yml` with your username and password

Type in console:

```ruby
rails db:create
```

```ruby
rails db:migrate
```

```ruby
rails db:migrate RAILS_ENV=test 
```

```ruby
rails db:seed
```

```ruby
rails db:seed RAILS_ENV=test
```

For automatic test:

```ruby
rails rswag
```

```ruby
rspec spec/requests/api/v1/articles_spec.rb
```

```ruby
rspec spec/requests/api/v1/comments_spec.rb
```

For test manually:

```ruby
rails s
```

Open Swagger UI in browser:
```ruby
http://127.0.0.1:3000/api-docs/index.html
```
