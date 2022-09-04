require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:rest1) { build(:restaurant) }
  let(:rest2) { build(:no_restaurant) }

  describe 'validations' do
    context 'when checking restaurant name presence' do
      it { is_expected.to validate_presence_of(:restaurant_name) }
    end

    context 'when saving restaurant' do
      it { expect(rest1.save).to be(true) }
      it { expect(rest2.save).to be(false) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:items).dependent(:destroy) }
  end
end
