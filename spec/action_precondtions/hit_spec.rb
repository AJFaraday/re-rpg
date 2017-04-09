require_relative '../spec_helper'

module ActionPreconditions
  describe Hit do

    let(:precondition) {Hit.new(percent: 50)}

    it 'should initialize with one argument' do
      expect {
        Hit.new(percent: 50)
      }.not_to raise_error
    end

    it 'should return zero if chance is missed' do
      Chance.any_instance.stub(:percent) {false}
      precondition.change(5).should eq(0)
    end

    it 'should return unchanged value if chance is correct' do
      Chance.any_instance.stub(:percent) {true}
      precondition.change(5).should eq(5)
    end

    it 'should decide based on the  percent argument' do
      results = 100.times.collect{ precondition.change(5)}
      # with a 50% hit percent, about half should be unchanged
      results.select{|x| x == 5}.count.should be_within(10).of(50)
    end

  end
end
