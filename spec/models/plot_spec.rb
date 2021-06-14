require 'rails_helper'

RSpec.describe Plot do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it {should have_many :plot_plants}
    it {should have_many(:plants).through(:plot_plants)}
  end

  describe 'plant_names' do
    it 'lists all the plant names for a plot' do
      garden1 = Garden.create!(name: 'Garden #1', organic: true)

      plot1 = Plot.create!(number: 1, size: 'large', direction: 'West', garden_id: garden1.id)

      plant1 = Plant.create!(name: 'potato', description: 'big', days_to_harvest: 15)
      plant2 = Plant.create!(name: 'sunflower', description: 'biggerer', days_to_harvest: 25)
      plant3 = Plant.create!(name: 'something else', description: 'its something', days_to_harvest: 50)
      plant4 = Plant.create!(name: 'Long plant', description: 'it takes a long time', days_to_harvest: 120)

      pp1 = PlotPlant.create!(plot_id: plot1.id, plant_id: plant1.id)
      pp3 = PlotPlant.create!(plot_id: plot1.id, plant_id: plant3.id)
      pp4 = PlotPlant.create!(plot_id: plot1.id, plant_id: plant4.id)

      expect(plot1.plant_names).to eq(([plant1.name, plant3.name, plant4.name]))
    end
  end
end
