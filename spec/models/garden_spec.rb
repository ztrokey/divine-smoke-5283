require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'fast_plants' do
    it 'shows unique list of plants with harvest under 100 days' do
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

      expect(@garden1.fast_plants).to eq([@plant1.name, @plant3.name, @plant2.name])
    end
  end
end
