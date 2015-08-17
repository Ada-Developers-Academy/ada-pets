class PetsController < ApplicationController
  def index
    pets = Pet.all
    render json: pets.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  def show
    pet = Pet.find_by(id: params[:id])
    
    if pet
      render json: pet.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: [], status: 204
    end
  end
end
