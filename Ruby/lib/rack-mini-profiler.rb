require 'mini_profiler/profiler'
require 'patches/sql_patches'
# require 'patches/net_patches'
require 'patches/active_resource_patches'
require 'patches/rails_cache_patches'

if defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i >= 3
  require 'mini_profiler_rails/railtie'
end
