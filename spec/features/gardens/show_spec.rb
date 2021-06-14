require 'rails_helper'

RSpec.describe 'garden show page' do
  before :each do
    @garden1 = Garden.create!(name: 'Garden #1', organic: true)

    @plot1 = Plot.create!(number: 1, size: 'large', direction: 'West', garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: 'small', direction: 'East', garden_id: @garden1.id)

    @plant1 = Plant.create!(name: 'potato', description: 'big', days_to_harvest: 15)
    @plant2 = Plant.create!(name: 'sunflower', description: 'biggerer', days_to_harvest: 25)
    @plant3 = Plant.create!(name: 'something else', description: 'its something', days_to_harvest: 50)
    @plant4 = Plant.create!(name: 'Long plant', description: 'it takes a long time', days_to_harvest: 120)

    @pp1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    @pp2 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant2.id)
    @pp3 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant3.id)
    @pp4 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant4.id)
    @pp5 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant1.id)

    visit "/gardens/#{@garden1.id}"
  end
  #   User Story 3, Garden's Plants
  # As a visitor
  # When I visit an garden's show page
  # Then I see a list of plants that are included in that garden's plots
  # And I see that this list is unique (no duplicate plants)
  # And I see that this list only includes plants that take less than 100 days to harvest
  it 'shows all the gardens plants' do
    expect(page).to have_content(@plant1.name)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)
    expect(page).to_not have_content(@plant4.name)
    expect(page).to have_content(@plant1.name, count: 1)
  end
end
