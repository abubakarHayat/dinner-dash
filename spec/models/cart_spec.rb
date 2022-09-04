require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { build(:cart) }

  describe 'associations' do
    it { is_expected.to have_many(:items).through(:cart_items) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'saving cart' do
    it 'saves the cart' do
      expect(cart.save).to be(true)
    end

    it 'doesn\'t save the cart' do
      cart_inv = described_class.new
      expect(cart_inv.save).to be(false)
    end
  end
end
