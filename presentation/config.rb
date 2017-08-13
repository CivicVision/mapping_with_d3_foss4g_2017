require 'rake/file_list'
require 'pathname'

activate :syntax
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :tables => true
set :url_root, 'https://civicvision.de'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'


activate :directory_indexes
activate :sprockets
sprockets.append_path File.join "#{root}", "bower_components"

configure :build do
  ignore '*.swp'
  activate :relative_assets
  set :relative_links, true
  set :http_prefix, '/mapping_with_d3_foss4g_2017'

end
activate :deploy do |deploy|
  deploy.method = :git
end
