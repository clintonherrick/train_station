require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_expections, false)

describe('adding a new train', {:type => :feature}) do
  it('allows a user to add a new train to the list of trains') do
    visit('/')
    click_link('Add New Train')
    fill_in('color', :with => 'blue')
    click_button('Add Train')
    expect(page).to have_content('Success!')
  end
end

describe('viewing all of the trains', {:type => :feature}) do
  it('allows a user to see all of the trains that have been listed') do
    train = Train.new({:color => 'green', :id => nil})
    train.save()
    visit('/')
    click_link('View All Trains')
    expect(page).to have_content('Your Current Trains')
  end
end

# describe('path to edit train', {:type => :feature}) do
#   it('allows user to update the color of the train line') do
#     visit('/')
#     click_link('Add New Train')
#     fill_in('color', :with => 'blue')
#     click_button('Add Train')
#     click_link('Return Home')
#     click_link('View All Trains')
#     click_link('green')
#     expect(page).to have_content('Edit blue Train')
#   end
# end

describe('return to home page', {:type => :feature}) do
  it('allows a user to return to the home page') do
    visit('/trains')
    click_link('Return Home')
    expect(page).to have_content('Welcome to the Train Station!')
  end
end

describe('adding a new city', {:type => :feature}) do
  it('allows a user to add a new city to the list of cities') do
    visit('/')
    click_link('Add New City')
    fill_in('location', :with => 'Paris' )
    click_button('Add City')
    expect(page).to have_content('Success')
  end
end

describe('viewing all of the cities', {:type => :feature}) do
  it('allows a user to see all of the cities that have been listed') do
    city = City.new({:location => 'Paris', :id => nil})
    city.save()
    visit('/')
    click_link('View All Cities')
    expect(page).to have_content("Your Current Cities")
  end
end

# describe('return to home page', {:type => :feature}) do
#   it('allows a user to return to the home page') do
#     visit('/cities')
#     click_link('Return Home')
#     expect(page).to have_content('Welcome to the Train Station!')
#   end
# end
