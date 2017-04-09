#require_relative './chance'

#require_relative './moving_attribute/attribute'
#require_relative './moving_attribute/module'

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