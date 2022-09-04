require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  describe 'validations' do
    context 'when checking presence of total' do
      it { is_expected.to validate_presence_of(:total) }
    end

    context 'when checking inclusion of status enum' do
      it { is_expected.to define_enum_for(:status).with_values(%i[ordered paid cancelled completed]) }
    end
  end

  describe 'associaitons' do
    it { is_expected.to have_many(:items).through(:order_items) }
  end

  describe 'saving the order' do
    it 'saves the order' do
      expect(order.save).to be(true)
    end

    it 'doesn\'t save the order' do
      order_inv = described_class.new
      expect(order_inv.save).to be(false)
    end
  end
end
