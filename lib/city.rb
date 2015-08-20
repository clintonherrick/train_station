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
    @location = attributes.fetch(:location, @location)
    DB.exec("UPDATE city SET location = '#{@location}' WHERE id = #{self.id()};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{self.id()}, #{train_id});")
    end
  end

  define_method(:trains) do
  city_stops = []
  results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{self.id()};")
  results.each() do |result|
    train_id = result.fetch("train_id").to_i()
    train = DB.exec("SELECT * FROM train WHERE id = #{train_id};")
    color = train.first().fetch("color")
    city_stops.push(Train.new({:color => color, :id => train_id}))
  end
  city_stops
end

  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE city_id = #{self.id()};")
    DB.exec("DELETE FROM city WHERE id = #{self.id()};")
  end


end
