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
  end
