# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DonorsWidget::Application.initialize!

if Rails.env == 'development' || Rails.env == 'test'
  RAW_URL = 'localhost:3000'
elsif Rails.env == 'production'
  RAW_URL = 'donors-widget.herokuapp.com'
else
  raise NotImplementedError, "The environment '#{Rails.env}' has no ROOT_URL\n Set one in config/initializers/faye_url.rb"
end
