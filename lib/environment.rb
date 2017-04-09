require 'active_support/core_ext/module/delegation'

paths =[
  '../*/*.rb',
  '../*.rb'
]
paths.each do |path|
  Dir.glob(File.expand_path(path, __FILE__)).each do |file|
    require file
  end
end

ChanceGenerator = Chance.new

# TODO do this in a separate initializer
require 'logger'
GameLogger = Logger.new(STDOUT)
