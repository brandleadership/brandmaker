require "brandmaker/version"
require "brandmaker/configuration"
require "brandmaker/job_config"
require "brandmaker/variable_purpose"
require "brandmaker/custom_structure"
require "brandmaker/grid_variable"
require "brandmaker/job"
require "brandmaker/media_variable"
require "brandmaker/external_media_variable"
require "brandmaker/variable_config"
require "brandmaker/variable"
require "brandmaker/variable_collection"

Savon.configure do |config|
  config.log = false
  config.log_level = :info
end
