require 'spec_helper'

# TestChance is an instance of Chance
# in the app, we will use ChanceGenerator
describe Chance do

  context 'percent' do

    it 'should return true 50% of the time' do
      results = 100.times.collect { TestChance.percent(50) }
      results.count(&:itself).should be_within(10).of(50)
    end

    it 'should return true 75% of the time' do
      results = 100.times.collect { TestChance.percent(75) }
      results.count(&:itself).should be_within(10).of(75)
    end

    it 'should return true 25% of the time' do
      results = 100.times.collect { TestChance.percent(25) }
      results.count(&:itself).should be_within(10).of(25)
    end

    it 'should return true 100% of the time' do
      results = 100.times.collect { TestChance.percent(100) }
      results.count(&:itself).should eq(100)
    end

    it 'should return true 0% of the time' do
      results = 100.times.collect { TestChance.percent(0) }
      results.count(&:itself).should eq(0)
    end

  end

  context 'proportion' do

    it 'should return true 6 in 12 times' do
      results = 12.times.collect { TestChance.proportion(6, 12) }
      results.count(&:itself).should be_within(2).of(6)
    end

    it 'should return true 2 in 6 times' do
      results = 6.times.collect { TestChance.proportion(2, 6) }
      results.count(&:itself).should be_within(2).of(2)
    end

    it 'should return true never for zero' do
      results = 6.times.collect { TestChance.proportion(0, 6) }
      results.count(&:itself).should eq(0)
    end

    it 'should return true always when two values are equal' do
      results = 6.times.collect { TestChance.proportion(6, 6) }
      results.count(&:itself).should eq(6)
    end

  end

  context 'roll die' do
    it 'should give a number between 1 and 6' do
      100.times { TestChance.roll_die(6).should be_between(1, 6) }
    end
  end


  context 'bag of dice' do

    it 'should roll 2 die 12' do
      results = TestChance.roll_bag([12, 12])
      results.should be_a(Chance::DieBag)
      results.length.should eq(2)
      results.each { |result| result.should be_between(1, 12) }
      results.sum.should be_between(2, 24)
    end

    it 'should roll a mixed bag of die' do
      results = TestChance.roll_bag([12, 12, 6, 4])
      results.should be_a(Chance::DieBag)
      results.length.should eq(4)
      results[0..1].each { |result| result.should be_between(1, 12) }
      results[2].should be_between(1, 6)
      results[3].should be_between(1, 4)
      results.sum.should be_between(4, 34)
    end

    it 'should tell us if the result is equal to or more than a target' do
      results = 100.times.collect { TestChance.roll_bag_for_target(12, [12, 12]) }
      results.count(&:itself).should be_within(10).of(50)
    end

  end

end

