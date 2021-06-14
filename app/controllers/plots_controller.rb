class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def edit
    plot = Plot.find(params[:id])
    plot.plants.delete(Plant.find(params[:plant_id]))
    redirect_to '/plots'
  end
end
