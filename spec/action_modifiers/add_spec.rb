require_relative '../spec_helper'

module ActionModifiers
  describe Add do

    let(:precondition) {Add.new(percent: 50, add: 2)}

    it 'should initialize with one argument' do
      expect {
        Add.new(percent: 50, add: 2)
      }.not_to raise_error
    end

    it 'should return unchanged value if chance is missed' do
      Chance.any_instance.stub(:percent) {false}
      precondition.change(5).should eq(5)
    end

    it 'should return multiplied value if chance is correct' do
      Chance.any_instance.stub(:percent) {true}
      precondition.change(5).should eq(7)
    end

    it 'should decide based on the percent argument' do
      results = 100.times.collect{ precondition.change(5)}
      # with a 50% critical percent, about half should be changed
      results.select{|x| x == 7}.count.should be_within(10).of(50)
    end

  end
end
