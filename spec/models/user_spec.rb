# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    context 'with valid attributes' do
      it { expect(user).to be_valid }
    end

    context 'when required attributes are missing' do
      %i[first_name last_name pseudo email].each do |attribute|
        it "is not valid without a #{attribute}" do
          user[attribute] = nil
          expect(user).not_to be_valid
        end
      end
    end

    context 'when attributes are not unique' do
      it 'is not valid with a non-unique pseudo' do
        create(:user, pseudo: 'duplicate')
        user.pseudo = 'duplicate'
        expect(user).not_to be_valid
      end

      it 'is not valid with a non-unique email' do
        create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        expect(user).not_to be_valid
      end
    end

    context 'with role validations' do
      it 'is not valid with an invalid role' do
        user.role = 'invalid_role'
        expect(user).not_to be_valid
      end

      it "is valid with a role of 'admin' or 'user'" do
        %w[admin user].each do |role|
          user.role = role
          expect(user).to be_valid
        end
      end
    end
  end

  describe '#admin?' do
    it 'returns true if the user is an admin' do
      user = build(:user, role: 'admin')
      expect(user.admin?).to be true
    end

    it 'returns false if the user is not an admin' do
      user = build(:user, role: 'user')
      expect(user.admin?).to be false
    end
  end

  describe '#user?' do
    it 'returns true if the user is a regular user' do
      user = build(:user, role: 'user')
      expect(user.user?).to be true
    end

    it 'returns false if the user is not a regular user' do
      user = build(:user, role: 'admin')
      expect(user.user?).to be false
    end
  end

  describe 'associations' do
    it 'has many articles' do
      association = described_class.reflect_on_association(:articles)
      expect(association.macro).to eq :has_many
    end
  end
end
