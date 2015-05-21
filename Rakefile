task default: ['haml:haml','coffee:coffee']
namespace :haml do
  require 'haml'
  def convert file, destination
    base_name = File.basename(file, '.haml') + '.html'
    html = File.open(file, 'r') { |f| Haml::Engine.new(f.read).render }
    File.open(File.join(destination, base_name), 'w') { |f| f.write html }
  end

  task :haml do
    Dir.glob('challenges/_source/**/*.haml') do |path|
      convert path, File.dirname(path).gsub('_source/','')
    end
    puts 'Parsed haml files'
  end
end

namespace :coffee do
  require 'coffee-script'
  def convert_coffee file, destination
    base_name = File.basename(file, '.coffee') + '.js'
    js = File.open(file, 'r') { |f| CoffeeScript.compile(File.open(f)) }
    File.open(File.join(destination, base_name), 'w') { |f| f.write js }
  end

  task :coffee do
    Dir.glob('challenges/_source/**/*.coffee') do |path|
      convert_coffee path, File.dirname(path).gsub('_source/','')
    end
    puts 'Parsed coffee files'
  end
end
