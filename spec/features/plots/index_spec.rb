require 'rails_helper'

RSpec.describe 'plots index page' do
  before :each do
    @garden1 = Garden.create!(name: 'Garden #1', organic: true)

    @plot1 = Plot.create!(number: 1, size: 'large', direction: 'West', garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: 'small', direction: 'East', garden_id: @garden1.id)

    @plant1 = Plant.create!(name: 'potato', description: 'big', days_to_harvest: 15)
    @plant2 = Plant.create!(name: 'sunflower', description: 'biggerer', days_to_harvest: 25)
    @plant3 = Plant.create!(name: 'something else', description: 'its something', days_to_harvest: 50)

    @pp1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    @pp3 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant3.id)
    @pp2 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant2.id)

    visit '/plots'
  end
    # User Story 1, Plots Index Page
  # As a visitor
  # When I visit the plots index page ('/plots')
  # I see a list of all plot numbers
  # And under each plot number I see names of all that plot's plants
  it 'shows a list of all the plot numbers and associated plot plants' do
    within "#plot-#{@plot1.id}" do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant3.name)
    end

    within "#plot-#{@plot2.id}" do
      expect(page).to have_content(@plant2.name)
    end
  end
  #   User Story 2, Remove a Plant from a Plot
  # As a visitor
  # When I visit a plot's index page
  # Next to each plant's name
  # I see a link to remove that plant from that plot
  # When I click on that link
  # I'm returned to the plots index page
  # And I no longer see that plant listed under that plot
  # (Note: you should not destroy the plant record entirely)
  it 'has a link to remove a plant from a plot' do
    # save_and_open_page
    within "#plot-#{@plot1.id}" do
      click_link "Remove #{@plant1.name}"
    end
    expect(current_path).to eq('/plots')
    
    within "#plot-#{@plot1.id}" do
      expect(page).to_not have_content(@plant1.name)
    end
    expect(Plant.all).to include(@plant1)
  end
end
