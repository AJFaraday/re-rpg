require_relative '../lib/environment.rb'
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = :should
  end
end

TestChance = Chance.new(Random.new(2))
