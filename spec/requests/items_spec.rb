require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:item_to_create) { attributes_for(:item_attr) }
  let(:valid_attributes) do
    {
      id: 1,
      item_title: 'Item 1',
      item_description: 'Good',
      item_price: 320,
      restaurant_id: Restaurant.create(restaurant_name: 'Rest 2').id
    }
  end
  let(:invalid_attributes) do
    {
      id: 'abcd',
      item_title: nil,
      item_description: 'Good',
      item_price: 101
    }
  end
  let(:user_admin) { create(:user_admin) }

  before do
    sign_in user_admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get items_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    context 'when user is unauthorized' do
      it 'renders a successful response with unauthorized user' do
        sign_out user_admin
        item = Item.create(valid_attributes)
        item.save
        get item_url(item)
        expect(response).to be_successful
      end
    end

    context 'when params are invalid' do
      it 'renders a unsuccessful response with invalid params' do
        get item_url(invalid_attributes)
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user is authorized and params are valid' do
      it 'renders a successful response with authorized user' do
        item = Item.create(valid_attributes)
        item.save
        get item_url(item)
        expect(response).to be_successful
      end
    end
  end

  # Get new
  describe 'GET /new' do
    context 'when user is unauthorized' do
      it 'denies access and redirects' do
        sign_out user_admin
        get new_item_url
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is authorized' do
      it 'renders a successful response with authorized user' do
        get new_item_url
        expect(response).to be_successful
      end
    end
  end

  # POST create
  describe 'POST /create' do
    context 'when user is unauthorized' do
      it 'denies access and redirects' do
        sign_out user_admin
        post '/items', params: { item: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are invalid' do
      it 'prevents action and redirects' do
        post '/items', params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is authorized and params are valid' do
      it 'renders a successful response with authorized user' do
        post '/items', params: { item: valid_attributes }
        expect(response).to redirect_to(item_path(assigns(:item)))
      end
    end
  end

  # Get edit
  describe 'GET /edit' do
    context 'when user is unauthorized' do
      it 'denies access and redirects' do
        sign_out user_admin
        item = Item.create(valid_attributes)
        item.save
        get edit_item_url(item)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is authorized' do
      it 'renders a successful response with authorized user' do
        item = Item.create(valid_attributes)
        item.save
        get edit_item_url(item)
        expect(response).to be_successful
      end
    end
  end

  # PATCH update
  describe 'PATCH /update' do
    let(:new_attributes) do
      {
        id: 2,
        item_title: 'New Item',
        item_description: 'Very Good',
        item_price: 230
      }
    end

    context 'when user is unauthorized' do
      it 'denies access and redirects' do
        sign_out user_admin
        item = Item.create(valid_attributes)
        item.save
        patch item_url(item), params: { item: {item_title: 'New Item'} }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are invalid' do
      it 'prevents action and redirects' do
        item = Item.create(valid_attributes)
        item.save
        patch item_url(item), params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is authorized and params are valid' do
      it 'updates the requested post' do
        item = Item.create(valid_attributes)
        item.save
        patch item_url(item), params: { item: new_attributes }
        expect(response).to redirect_to(item_url(item))
      end
    end
  end

  # Delete
  describe 'DELETE /destroy' do
    context 'when user is unauthorized' do
      it 'doesn\'t delete the item with unauthorized user' do
        sign_out user_admin
        item = Item.create(valid_attributes)
        item.save
        expect { delete item_url(item) }.to change(Item, :count).by(0)
      end
    end

    context 'when params are invalid' do
      it 'doesn\'t delete the item' do
        item = Item.create(valid_attributes)
        item.save
        expect do
          delete item_url(invalid_attributes)
        end.to change(Item, :count).by(0)
      end
    end

    context 'when user is authorized and params are valid' do
      it 'renders a successful response with authorized user' do
        item = Item.create(valid_attributes)
        item.save
        expect { delete item_url(item) }.to change(Item, :count).by(-1)
      end
    end
  end

  # add_to_cart
  describe 'POST /add_to_cart' do
    before do
      Cart.create(user_id: user_admin.id)
    end

    context 'when item is added to cart' do
      it 'adds the item to cart' do
        item = Item.create(valid_attributes)
        item.save
        post add_to_cart_item_url(item), xhr: true
        expect(flash[:notice]).to eq('Item added to cart')
      end
    end

    context 'when items from 2 different is added to cart by authenticated user' do
      before do
        item1 = Item.create(valid_attributes)
        item1.save
        post add_to_cart_item_url(item1), xhr: true
      end

      it 'doesn\'t add the item to cart' do
        temp_attr = valid_attributes
        temp_attr[:restaurant_id] = Restaurant.create(restaurant_name: 'Another rest').id
        temp_attr[:id] = 10
        item2 = Item.create(temp_attr)
        item2.save
        post add_to_cart_item_url(item2), xhr: true
        expect(flash[:notice]).to eq('Item from 2 different restaurants cannot be added at the same time in the cart!')
      end
    end

    context 'when items from 2 different is added to cart by unauthenticated user' do
      before do
        sign_out user_admin
        item1 = Item.create(valid_attributes)
        item1.save
        post add_to_cart_item_url(item1), xhr: true
      end

      it 'doesn\'t add the item to cart' do
        temp_attr = valid_attributes
        temp_attr[:restaurant_id] = Restaurant.create(restaurant_name: 'Another rest').id
        temp_attr[:id] = 10
        item2 = Item.create(temp_attr)
        item2.save
        post add_to_cart_item_url(item2), xhr: true
        expect(flash[:notice]).to eq('Item from 2 different restaurants cannot be added at the same time in the cart!')
      end
    end
  end
end
