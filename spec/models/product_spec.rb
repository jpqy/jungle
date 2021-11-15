# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    category = Category.new(name: 'Test Category')
    subject do
      described_class.new(name: 'Anything',
                          price_cents: 100,
                          quantity: 1,
                          category: category)
    end

    it 'is valid with filled attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a price' do
      subject.price_cents = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a quantity' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a category' do
      subject.category = nil
      expect(subject).to_not be_valid
    end

    it 'should have an expect error' do
      subject.category = nil
      subject.save
      puts subject.errors
      expect(subject.errors.full_messages).to_not be_empty
    end
  end
end
