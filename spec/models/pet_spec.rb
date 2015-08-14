require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    let(:rosa) { Pet.new name: 'Rosalita', human: 'Jeremy' }
    let(:rosa_again) { rosa.dup }

    it "requires a name" do
      p = Pet.new
      expect(p).to_not be_valid
      expect(p.errors.keys).to include :name
    end

    it "requires a human" do
      p = Pet.new
      expect(p).to_not be_valid
      expect(p.errors.keys).to include :human
    end

    it "requires a pet's name to be unique per human" do
      expect(rosa).to be_valid
      rosa.save

      expect(rosa_again).to_not be_valid
      expect(rosa_again.errors.keys).to include :name
    end
  end
end
