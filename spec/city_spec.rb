require('spec_helper')

describe(City) do
  describe('#==') do
    it("is the same city if it has the same id") do
      city1 = City.new({:location => "Paris", :id => nil})
      city2 = City.new({:location => "Paris", :id => nil})
      expect(city1).to(eq(city2))
    end
  end

  describe('.all') do
    it('returns an empty list of cities at first') do
      expect(City.all()).to(eq([]))
    end
  end

  describe('location') do
    it("lets you view the name of the location") do
      test_city = City.new({:location => "Paris", :id => nil})
      expect(test_city.location()).to(eq("Paris"))
    end
  end

  describe('#id') do
    it('sets the city id when you save it') do
      test_city = City.new({:location => "Paris", :id => nil})
      test_city.save()
      expect(test_city.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('adds a city to the array of saved cities') do
      test_city = City.new({:location => "Paris", :id => nil})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  # describe('#trains') do
  #   it("returns an array of train for that city") do
  #     test_city = City.new({:location => "Paris", :id => nil})
  #     test_city.save()
  #     test_train = Train.new({:color => "blue"})
  #     test_train.save()
  #     test_train2 = Train.new({:color => "red"})
  #     test_train2.save()
  #     expect(test_city.trains()).to(eq([test_train, test_train2]))
  #   end
  # end
end
