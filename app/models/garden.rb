class Garden < ApplicationRecord
  has_many :plots

  def fast_plants
    plots.joins(:plants).where('days_to_harvest < 100').distinct.pluck(:name)
  end
end
