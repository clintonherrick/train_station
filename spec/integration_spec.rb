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

describe('return to home page', {:type => :feature}) do
  it('allows a user to return to the home page') do
    visit('/trains')
    # binding.pry
    click_link('Return Home')
    expect(page).to have_content('Welcome to the Train Station!')
  end
end
