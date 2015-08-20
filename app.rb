require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/train")
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname=> 'train_station'})

get("/") do
  @cities = City.all()
  @trains = Train.all()
  erb(:index)
end

get("/cities") do
  @cities = City.all()
  erb(:cities)
end

get("/trains") do
  @trains = Train.all()
  erb(:trains)
end

post("/cities") do
  location = params.fetch("location")
  city = City.new({:location => location, :id => nil})
  city.save()
  @cities = City.all()
  erb(:cities)
end

post("/trains") do
  color = params.fetch("color")
  train = Train.new({:color => color, :id => nil})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_info)
end

get("/trains/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_info)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city_info)
end

patch("/trains/:id") do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train_info)
end

# get("/cities/new") do
#   erb(:city_form)
# end
#
# post('/cities') do
#   location = params.fetch("location")
#   city = City.new({:location => location, :id => nil})
#   city.save()
#   erb(:success)
# end
#
# get('/cities') do
#   @cities = City.all()
#   erb(:cities)
# end
#
# get('/cities/:id') do
#   @city = City.find(params.fetch('id').to_i())
#   erb(:city)
# end
#
# get("/cities/:id/edit") do
#   @city = City.find(params.fetch("id").to_i())
#   erb(:city_edit)
# end
#
# patch("/cities/:id") do
#   location = params.fetch("location")
#   @city = City.find(params.fetch("id").to_i())
#   @city.update({:location => location})
#   erb(:city)
# end
#
# delete('/cities/:id') do
#   @city = City.find(params.fetch("id").to_i())
#   @city.delete()
#   @cities = City.all()
#   erb(:index)
# end
#
# get("/trains/new") do
#   erb(:train_form)
# end
#
# post('/trains') do
#   color = params.fetch("color")
#   train = Train.new({:color => color, :id => nil})
#   train.save()
#   erb(:success)
# end
#
# get('/trains') do
#   @trains = Train.all()
#   erb(:trains)
# end
#
# get('/trains/:id') do
#   @train = Train.find(params.fetch('id').to_i())
#   erb(:train)
# end
#
# get('/trains/:id/edit') do
#   @train = Train.find(params.fetch("id").to_i())
#   erb(:train_edit)
# end
#
# patch("/trains/:id") do
#   color = params.fetch("color")
#   @train = Train.find(params.fetch("id").to_i())
#   @train.update({:color => color})
#   erb(:train)
# end
#
# delete('/trains/:id') do
#   @train = Train.find(params.fetch("id").to_i())
#   @train.delete()
#   @trains = Train.all()
#   erb(:index)
# end
#
#
#

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
