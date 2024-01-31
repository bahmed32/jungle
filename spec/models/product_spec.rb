require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'will check that all four categories are set anf are working' do 
      @category = Category.create(name: 'Tree')
      @product = Product.create(name: 'Evergreen', category: @category, quantity: 1, price: 30)
      expect(@product.save!).to be true
      expect(@product).to be_valid
    end

    it ' will have an error if no name is provided' do
      @category = Category.create(name: 'Tree')
      @product = Product.create(category: @category, quantity: 1, price: 30)
      expect(@product.errors.full_messages[0]).to eq "Name can't be blank"
    end
    it ' will have an error if no price is provided' do
      @category = Category.create(name: 'Tree')
      @product = Product.create(name: 'Evergreen', category: @category, quantity: 1)
      expect(@product.errors.full_messages[0]).to eq "Price cents is not a number"
    end

    it ' will have an error if no quantitiy is provided' do
      @category = Category.create(name: 'Tree')
      @product = Product.create(name: 'Evergreen', category: @category, price: 30)
      expect(@product.errors.full_messages[0]).to eq "Quantity can't be blank"
    end

    it ' will have an error if no category is provided' do
      @category = Category.create(name: 'Tree')
      @product = Product.create(name: 'Evergreen', price: 30)
      expect(@product.errors.full_messages[0]).to eq "Category must exist"
    end





  end
end
