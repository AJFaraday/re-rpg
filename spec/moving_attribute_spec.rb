require 'spec_helper'

describe MovingAttribute do

  class TestClass
    include MovingAttribute
    moving_attribute :health, 5, 5
    moving_attribute :magic, 1, 2
  end

  before(:each) do
    @test_instance = TestClass.new
  end

  it 'should get the current value of attributes' do
    @test_instance.get(:health).should eq(5)
    @test_instance.get(:magic).should eq(1)
  end

  it 'should get the maximum value of attributes' do
    @test_instance.maximum(:health).should eq(5)
    @test_instance.maximum(:magic).should eq(2)
  end

  it 'should increase the value' do
    @test_instance.change(:magic, 1)
    @test_instance.get(:magic).should eq(2)
  end

  it 'should not increase the value beyond the maximum' do
    @test_instance.change(:magic, 5)
    @test_instance.get(:magic).should eq(2)

    @test_instance.change(:health, 2)
    @test_instance.get(:health).should eq(5)
  end

  it 'should decrease the value' do
    @test_instance.change(:magic, -1)
    @test_instance.get(:magic).should eq(0)
  end

  it 'should not decrease the value beyond the zero' do
    @test_instance.change(:magic, -3)
    @test_instance.get(:magic).should eq(0)

    @test_instance.change(:health, -20)
    @test_instance.get(:health).should eq(0)
  end

  it 'should fill an attribute' do
    @test_instance.fill(:magic)
    @test_instance.get(:magic).should eq(2)
  end

  it 'should empty an attribute' do
    @test_instance.empty(:magic)
    @test_instance.get(:magic).should eq(0)
  end

  context 'errors' do

    it 'should throw an error when you get an unknown attribute' do
      expect { @test_instance.get(:awesomeness) }.to raise_error(MovingAttribute::UnknownAtributeError)
    end

    it 'should throw an error when you get maximum for an unknown attribute' do
      expect { @test_instance.maximum(:awesomeness) }.to raise_error(MovingAttribute::UnknownAtributeError)
    end

    it 'should throw an error when you change an unknown attribute' do
      expect { @test_instance.change(:awesomeness, 100) }.to raise_error(MovingAttribute::UnknownAtributeError)
    end

    it 'should throw an error when you fill an unknown attribute' do
      expect { @test_instance.fill(:awesomeness) }.to raise_error(MovingAttribute::UnknownAtributeError)
    end

    it 'should throw an error when you empty an unknown attribute' do
      expect { @test_instance.empty(:awesomeness) }.to raise_error(MovingAttribute::UnknownAtributeError)
    end

  end

end
