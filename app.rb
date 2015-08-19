require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname=> 'train_station_test'})

get("/") do
  erb(:index)
end


get("/cities/new") do
  erb(:city_form)
end

post('/cities') do
  location = params.fetch("location")
  city = City.new({:location => location, :id => nil})
  city.save()
  erb(:success)
end

get('/cities') do
  @cities = City.all()
  erb(:cities)
end

get('/cities/:id') do
  @city = City.find(params.fetch('id').to_i())
  erb(:city)
end

get("/cities/:id/edit") do
  @city = City.find(params.fetch("id").to_i())
  erb(:city_edit)
end

patch("/cities/:id") do
  location = params.fetch("location")
  @city = City.find(params.fetch("id").to_i())
  @city.update({:location => location})
  erb(:city)
end

get("/trains/new") do
  erb(:train_form)
end

post('/trains') do
  color = params.fetch("color")
  train = Train.new({:color => color, :id => nil})
  train.save()
  erb(:success)
end

get('/trains') do
  @trains = Train.all()
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params.fetch('id').to_i())
  erb(:train)
end

get('trains/:id/edit') do
  @train = Train.find(params.fetch("id").to_i())
  erb(:train_edit)
end

patch("/trains:id") do
  color = params.fetch("color")
  @train = Train.find(params.fetch("id").to_i())
  @train.update({:color => color})
  erb(:train)
end


# post("/tasks") do
#   description = params.fetch("description")
#   list_id = params.fetch("list_id").to_i()
#   due = params.fetch("due")
#   @list = List.find(list_id)
#   # binding.pry
#   @task = Task.new({:description => description, :list_id => list_id, :due => due, :id => nil})
#   @task.save()
#   erb(:success)
# end
