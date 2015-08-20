class City
  attr_reader(:location, :id)

  define_method(:initialize) do |attributes|
    @location = attributes.fetch(:location)
    @id = attributes.fetch(:id)
  end

  define_method (:==) do |another_city|
    self.id().==another_city.id()
  end



  define_singleton_method(:all) do
    returned_city = DB.exec("SELECT * FROM city;")
    cities = []
    returned_city.each() do |city|
      location = city.fetch("location")
      id = city.fetch("id").to_i()
      cities.push(City.new({:location => location, :id => id}))
    end
    cities
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO city (location) VALUES ('#{@location}') RETURNING id;")
    @id  = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_city = nil
    City.all().each() do |city|
      if city.id().==(id)
        found_city = city
      end
    end
    found_city
  end

  define_method(:update) do |attributes|
    @location = attributes.fetch(:location)
    @id = self.id()
    DB.exec("UPDATE city SET location = '#{@location}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM city WHERE id = #{self.id()};")
  end
end
