class Train
  attr_reader(:color, :id)
    define_method(:initialize) do |attributes|
      @color = attributes.fetch(:color)
      @id = attributes.fetch(:id)
    end

  define_method(:==) do |another_train|
    self.id().==another_train.id()
  end

  define_singleton_method(:all) do
    returned_train = DB.exec("SELECT * FROM train;")
    trains = []
    returned_train.each() do |train|
      color = train.fetch("color")
      id = train.fetch("id").to_i()
      trains.push(Train.new({:color => color, :id => id}))
    end
    trains
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO train (color) VALUES ('#{color}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM train *")
  end

  define_method(:update) do |attributes|
    @color = attributes.fetch(:color, @color)
    DB.exec("UPDATE train SET color = '#{@color}' WHERE id = #{self.id()};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{city_id}, #{self.id()});")
    end
  end

  define_method(:cities) do
    city_stops = []
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM city WHERE id = #{city_id};")
      location = city.first().fetch("location")
      city_stops.push(City.new({:location => location, :id => city_id}))
    end
    city_stops
  end

  define_singleton_method(:find) do |id|
    found_train = nil
    Train.all().each() do |train|
      if train.id().==(id)
        found_train = train
      end
    end
    found_train
  end

  define_method(:delete) do
    DB.exec("DELETE FROM train WHERE id = #{self.id()};")
  end


end
