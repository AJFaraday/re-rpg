require_relative '../spec_helper'

module ActionPreconditions
  describe Critical do

    let(:precondition) {Critical.new(percent: 50,  multiplier: 2)}

    it 'should initialize with one argument' do
      expect {
        Critical.new(percent: 50, multiplier: 2)
      }.not_to raise_error
    end

    it 'should return unchanged value if chance is missed' do
      Chance.any_instance.stub(:percent) {false}
      precondition.change(5).should eq(5)
    end

    it 'should return multiplied value if chance is correct' do
      Chance.any_instance.stub(:percent) {true}
      precondition.change(5).should eq(10)
    end

    it 'should decide based on the percent argument' do
      results = 100.times.collect{ precondition.change(5)}
      # with a 50% critical percent, about half should be changed
      results.select{|x| x == 10}.count.should be_within(10).of(50)
    end

  end
end
