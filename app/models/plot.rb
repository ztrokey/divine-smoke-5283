class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants
  has_many :plants, through: :plot_plants

  def plant_names
    plants.pluck(:name)
    #I didn't use this method but my thoughts were to try to use it
    #to clean up the double iteration on the plots index page
  end
end
