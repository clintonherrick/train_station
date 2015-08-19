require('spec_helper')


describe(Train) do
  describe('#==')do
    it('is the same train if it has the same id') do
      train1 = Train.new({:color => "blue", :id => nil})
      train2 = Train.new({:color => "blue", :id => nil})
      expect(train1).to(eq(train2))
    end
  end


  describe('.all') do
    it("returns an empty list of trains at first") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#color') do
    it("assigns a color to the train line") do
      test_train = Train.new({:color => "blue", :id => nil})
      expect(test_train.color()).to(eq("blue"))
    end
  end

  describe('#id') do
    it("sets the train id when you save it") do
      test_train = Train.new({:color => "blue", :id => nil})
      test_train.save()
      expect(test_train.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('adds a train to the array of the saved trains') do
      test_train = Train.new({:color => "blue", :id => nil})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe(".clear") do
    it("empties out all of the trains") do
      Train.new({:color => "blue", :id => nil})
      Train.clear()
      expect(Train.all()).to(eq([]))
    end
  end
end
