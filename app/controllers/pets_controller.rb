class PetsController < ApplicationController
  def index
    pets = Pet.all
    render :json => pets.as_json(except: [:created_at, :updated_at]),
      :status => :ok
  end

  def show
  end
end
