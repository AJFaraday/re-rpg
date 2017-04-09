require_relative '../lib/environment'
require 'benchmark'

def test_random_mechanism(kls)
  generator = Chance.new(kls.new)
  puts "Rolling 2 die 6, a MILLION times using #{kls}"
  x = Hash.new(0)
  benchmark = Benchmark.measure do
    1000000.times.collect { generator.roll_bag([6, 6]).sum }.collect { |v| x[v] += 1 }
    x.sort.each { |k, v| puts "#{k}: #{v} times" }
  end
  puts ''
  puts "Finished in #{benchmark.real} seconds"
  puts ''
end

test_random_mechanism(Random)
test_random_mechanism(IncrementRandom)
test_random_mechanism(TimeRandom)
