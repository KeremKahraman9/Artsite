source "https://rubygems.org"

ruby "3.4.5"

gem "rails", "~> 7.2"
gem "sprockets-rails"
gem "sqlite3", "~> 1.7"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false

# Authentication
gem "devise"

# Image processing for Active Storage
gem "image_processing", "~> 1.2"

# Pagination
gem "pagy", "~> 6.0"

# Search
gem "ransack", "~> 4.0"

# JSON serialization
gem "jsonapi-serializer"

# HTTP client
gem "httparty"

# Background jobs
gem "solid_queue"

# Caching
gem "solid_cache"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "faker"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
