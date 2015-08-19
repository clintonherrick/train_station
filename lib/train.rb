class Train
  attr_reader(:color, :id)
    define_method(:initialize) do |attributes|
      @color = attributes.fetch(:color)
      @id = attributes.fetch(:id)
    end
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
