require 'spec_helper'

# TestChance is an instance of Chance
# in the app, we will use ChanceGenerator
describe Chance do

  context 'percent' do

    it 'should return true 50% of the time' do
      results = 100.times.collect{ TestChance.percent(50) }
      results.select{|x|x}.count.should be_within(10).of(50)
    end

    it 'should return true 75% of the time' do
      results = 100.times.collect{ TestChance.percent(75) }
      results.select{|x|x}.count.should be_within(10).of(75)
    end

    it 'should return true 25% of the time' do
      results = 100.times.collect{ TestChance.percent(25) }
      results.select{|x|x}.count.should be_within(10).of(25)
    end

    it 'should return true 100% of the time' do
      results = 100.times.collect{ TestChance.percent(100) }
      results.select{|x|x}.count.should eq(100)
    end

    it 'should return true 0% of the time' do
      results = 100.times.collect{ TestChance.percent(0) }
      results.select{|x|x}.count.should eq(0)
    end

  end

  context 'proportion' do

    it 'should return true 6 in 12 times' do
      results = 12.times.collect{ TestChance.proportion(6, 12) }
      results.select{|x|x}.count.should be_within(2).of(6)
    end

    it 'should return true 2 in 6 times' do
      results = 6.times.collect{ TestChance.proportion(2, 6) }
      results.select{|x|x}.count.should be_within(2).of(2)
    end

  end

end

