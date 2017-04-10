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
GameLogger.formatter = proc do |severity, datetime, progname, msg|
  time = datetime.strftime("%H:%M:%S %3N")
  "#{time} #{msg}\n"
end
