# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article) }

  describe 'validations' do
    context 'with valid attributes' do
      it { expect(article).to be_valid }
    end

    context 'when required attributes are missing' do
      attributes = {
        name: nil,
        description: nil,
        first_price: nil,
        start_date: nil,
        end_date: nil,
        category: nil
      }

      attributes.each do |attribute, value|
        it "is not valid without a #{attribute}" do
          article.update(attribute => value)
          expect(article).to_not be_valid
        end
      end
    end

    context 'with invalid dates' do
      it 'is not valid if the start_date is in the past' do
        article.start_date = DateTime.now - 1.day
        expect(article).to_not be_valid
      end

      it 'is not valid if the end_date is in the past' do
        article.end_date = DateTime.now - 1.day
        expect(article).to_not be_valid
      end

      it 'is not valid if the end_date is before the start_date' do
        article.start_date = DateTime.now + 2.days
        article.end_date = DateTime.now + 1.day
        expect(article).to_not be_valid
      end
    end
  end

  describe '#get_highest_bid' do
    context 'when there are no bids' do
      it 'returns the first_price' do
        expect(article.get_highest_bid).to eq(article.first_price)
      end
    end
  end

  describe '#get_winner' do
    context 'when the auction is not over or there are no bids' do
      it "returns 'zero_winner'" do
        expect(article.get_winner).to eq(I18n.t('article.zero_winner'))
      end
    end
  end
end
