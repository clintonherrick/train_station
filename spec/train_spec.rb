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

  describe("#update") do
    it("lets you update trains in the database") do
      train= Train.new({:color => "blue", :id => nil})
      train.save()
      train.update({:color => "green"})
      expect(train.color()).to(eq("green"))
    end

    it('lets you add a stop to a train line') do
      train = Train.new({:color => "blue", :id => nil})
      train.save()
      salem = City.new({:location => "Salem", :id => nil})
      salem.save()
      detroit = City.new({:location => "Detroit", :id => nil})
      detroit.save()
      train.update({:city_ids => [salem.id(), detroit.id()]})
      expect(train.cities()).to(eq([salem, detroit]))
    end
  end

  describe("#cities") do
    it("returns all of the stops in a particular train line") do
      train = Train.new({:color => "blue", :id => nil})
      train.save()
      salem = City.new({:location => "Salem", :id => nil})
      salem.save()
      detroit = City.new({:location => "Detroit", :id => nil})
      detroit.save()
      train.update({:city_ids => [salem.id(), detroit.id()]})
      expect(train.cities()).to(eq([salem, detroit]))
    end
  end

  describe('.find') do
      it("returns a train by its id") do
        test_train = Train.new({:color => "blue", :id => nil})
        test_train.save()
        test_train2 = Train.new({:color => "green", :id => nil})
        test_train2.save()
        expect(Train.find(test_train2.id())).to(eq(test_train2))
      end
    end

    describe("#delete") do
      it("lets you delete a train from the database") do
        train = Train.new({:color => "blue", :id => nil})
        train.save()
        train2 = Train.new({:color => "green", :id => nil})
        train2.save()
        train.delete()
        expect(Train.all()).to(eq([train2]))
      end
    end

end
