require 'rails_helper'

RSpec.describe PetsController, type: :controller do
  let(:rosa)   { Pet.create(name: "Rosalita", human: "<3Jeremy!", age: 7) }
  let(:raquel) { Pet.create(name: "Raquel",   human: "<3Jeremy!", age: 12) }
  let(:keys)   { ["age", "human", "id", "name"] }

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.response_code).to eq 200
    end

    it "returns json" do
      get :index
      expect(response.header['Content-Type']).to include 'application/json'
    end

    context "the returned json object" do
      before :each do
        rosa
        raquel
        get :index
        @response = JSON.parse response.body
      end

      it "is an array of pet objects" do
        expect(@response).to be_an_instance_of Array
        expect(@response.length).to eq 2
      end

      it "includes only the id, name, human, and age keys" do
        expect(@response.map(&:keys).flatten.uniq.sort).to eq keys
      end
    end
  end

  describe "GET 'show'" do    
    it "is successful" do
      get :show, id: rosa.id
      expect(response.response_code).to eq 200
    end

    it "returns json" do
      get :show, id: rosa.id
      expect(response.header['Content-Type']).to include 'application/json'
    end

    context "the returned json object" do
      before :each do
        get :show, id: rosa.id
        @response = JSON.parse response.body
      end

      it "has the right keys" do
        expect(@response.keys.sort).to eq keys
      end

      it "has all of Rosa's info" do
        keys.each do |key|
          expect(@response[key]).to eq rosa[key]
        end
      end
    end

    context "no pets found" do
      before :each do
        get :show, id: 1000
      end

      it "is successful" do
        expect(response).to be_successful
      end

      it "returns a 204 (no content)" do
        expect(response.response_code).to eq 204
      end

      it "expects the response body to be an empty array" do
        expect(response.body).to eq "[]"
      end
    end
  end

  describe "GET 'search'" do
    pending "Implement fuzzy name search"
  end
end
