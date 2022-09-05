require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { build(:user) }
  let(:user2) { build(:user_new_email) }
  let(:inv_user1) { build(:user_inv) }
  let(:inv_user2) { build(:user_inv2) }

  # validations
  describe 'validations' do
    context 'when checking presence of first_name' do
      it { is_expected.to validate_presence_of(:first_name) }
    end

    context 'when checking presence of last_name' do
      it { is_expected.to validate_presence_of(:last_name) }
    end

    context 'when checking presence of password' do
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'when checking length of password' do
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end

    context 'when checking length of display name and optionality' do
      it { is_expected.to validate_length_of(:display_name).is_at_least(2).is_at_most(31) }
    end

    context 'when checking unique email' do
      subject { user2 }

      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end

    context 'when checking user is admin' do
      let(:user_admin) { create(:user_admin) }

      it { expect(user_admin.admin?).to be(true) }
    end
  end

  describe 'saving the object' do
    context 'when saving the user' do
      it { expect(user1.save).to be(true) }
      it { expect(user2.save).to be(true) }
    end

    context 'when not saving the user' do
      it { expect(inv_user1.save).to be(false) }
      it { expect(inv_user2.save).to be(false) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:orders).class_name('Order').dependent(:destroy) }
    it { is_expected.to have_one(:cart).class_name('Cart').dependent(:destroy) }
  end
end
