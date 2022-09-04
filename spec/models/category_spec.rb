require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }
  let(:category2) { build(:no_category) }

  describe 'validations' do
    context 'when checking presence of category name' do
      it { is_expected.to validate_presence_of(:category_name) }
    end

    context 'when saving the category' do
      it { expect(category.save).to be(true) }
      it { expect(category2.save).to be(false) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:items).through(:category_items) }
  end
end
