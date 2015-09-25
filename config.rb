require './env' if File.exists?('env.rb')

###
# Config
###

config[:autoload_sprockets] = true
# config[:automatic_directory_matcher = nil
config[:build_dir] = '../build'
config[:css_dir] = 'stylesheets'
# config[:data_dir] = 'data'
# config[:environment] = :build
# config[:fonts_dir] = 'fonts'
# config[:helpers_dir] = 'helpers'
# config[:helpers_filename_glob] = '**.rb'
# config[:http_prefix] = '/'
# config[:https] = false
config[:images_dir] = 'media/images'
# config[:index_file] = 'index.html'
config[:js_dir] = 'javascripts'
# config[:layout] = :_auto_layout
# config[:layouts_dir] = 'layouts'
config[:markdown_engine] = :kramdown
# config[:markdown_engine_prefix] = Tilt
config[:partials_dir] = 'partials'
# config[:port] = 4567
# config[:protect_from_csrf] = false
config[:relative_links] = true
# config[:show_exceptions] = true
# config[:source] = 'source'
# config[:ssl_certificate] = nil
# config[:ssl_private_key] = nil
# config[:strip_index_file] = true
# config[:trailing_slash] = true

after_configuration do
   sprockets.append_path File.join root.to_s, "source/dependencies"
end

###
# Helpers
###

require "helpers/blog_helpers" 
helpers BlogHelpers

###
# Extensions
###

# Global
activate :relative_assets
activate :directory_indexes
activate :automatic_image_sizes
activate :automatic_alt_tags

ignore 'dependencies/*'

# Environment: Development
configure :development do
  # activate :cache_buster
   activate :livereload
end

# Environment: Build
configure :build do
  # activate :minify_css
  # activate :minify_javascript
  # activate :asset_host, :host => ''
  # activate :gzip
end

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "repeat"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "repeat/tag.html"
  blog.calendar_template = "repeat/calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = ENV['S3_BUCKET']
  s3_sync.region                     = ENV['S3_REGION']
  s3_sync.aws_access_key_id          = ENV['S3_KEY']
  s3_sync.aws_secret_access_key      = ENV['S3_SECRET']
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default. 
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false 
end
