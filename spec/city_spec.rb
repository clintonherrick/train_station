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

  describe("#update") do
    it("lets you update cities in the database") do
      city = City.new({:location => "Paris", :id => nil})
      city.save()
      city.update({:location => "Amsterdam"})
      expect(city.location()).to(eq("Amsterdam"))
    end
  end

  describe('.find') do
      it("returns a city by its id") do
        test_city = City.new({:location => "Paris", :id => nil})
        test_city.save()
        test_city2 = City.new({:location => "Amsterdam", :id => nil})
        test_city2.save()

        expect(City.find(test_city2.id())).to(eq(test_city2))
      end
    end

    describe("#delete") do
      it("lets you delete a city from the database") do
        city = City.new({:location => "Paris", :id => nil})
        city.save()
        city2 = City.new({:location => "Amsterdam", :id => nil})
        city2.save()
        city.delete()
        expect(City.all()).to(eq([city2]))
      end
    end

end
