require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:rest1) { create(:restaurant) }
  let(:item) { build(:item) }

  describe 'validations' do
    context 'when checking item_price presence' do
      it { is_expected.to validate_presence_of(:item_price) }
    end

    context 'when checking item_description presence' do
      it { is_expected.to validate_presence_of(:item_description) }
    end

    context 'when checking item_title presence' do
      it { is_expected.to validate_presence_of(:item_title) }
    end

    context 'when checking item image type' do
      it 'doesn\'t accept wrong file(image) type' do
        file_path = Rails.root.join('spec/fixtures/example.txt')
        item.image = ActiveStorage::Blob.create_after_upload!(io: File.open(file_path, 'rb'), filename: 'example.txt').signed_id
        item.send(:check_image_type)
        expect(item.errors[:image]).to eq(['Image must be a JPEG or PNG!'])
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:categories).through(:category_items) }
    it { is_expected.to have_many(:orders).through(:order_items) }
    it { is_expected.to have_many(:carts).through(:cart_items) }
    it { is_expected.to belong_to(:restaurant) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'scopes' do
    it 'includes items that are to be sold' do
      item = described_class.create!(item_title: 'Biryani', item_description: 'Meat & RICE', item_price: 350,
                                     restaurant_id: rest1.id)
      expect(described_class.sold_items).to include(item)
    end
  end
end
