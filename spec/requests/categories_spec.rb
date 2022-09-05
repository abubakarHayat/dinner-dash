require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:user_admin) { create(:user_admin) }
  let(:valid_attributes) do
    {
      category_name: 'Category 1'
    }
  end
  let(:invalid_attributes) do
    {
      id: 'abcd',
      category_name: ''
    }
  end

  before do
    sign_in user_admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get categories_url
      expect(response).to be_successful
    end
  end

  # show
  describe 'GET /show' do
    context 'when show action is called' do
      it 'renders a successful response' do
        cat = Category.create(valid_attributes)
        cat.save
        get category_url(cat)
        expect(response).to be_successful
      end
    end
  end

  # new
  describe 'GET /new' do
    context 'when user is not authorized' do
      it 'renders a unsuccessful response with authorized user' do
        sign_out user_admin
        get new_category_url
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is authorized' do
      it 'renders a successful response with authorized user' do
        get new_category_url
        expect(response).to be_successful
      end
    end
  end

  #POST CREATE
  describe 'POST /create' do
    context 'when user is unauthorized' do
      it 'denies access and redirects' do
        sign_out user_admin
        post '/categories', params: { category: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are invalid' do
      it 'prevents action and redirects' do
        post '/categories', params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is authorized and params are valid' do
      it 'renders a successful response with authorized user' do
        post '/categories', params: { category: valid_attributes }
        expect(response).to redirect_to(category_path(assigns(:category)))
      end
    end
  end

  # Delete
  describe 'DELETE /destroy' do
    context 'when user is unauthorized' do
      it 'doesn\'t delete the item with unauthorized user' do
        sign_out user_admin
        cat = Category.create(valid_attributes)
        cat.save
        expect { delete category_url(cat) }.to change(Category, :count).by(0)
      end
    end

    context 'when params are invalid' do
      it 'doesn\'t delete the item' do
        cat = Category.create(valid_attributes)
        cat.save
        expect { delete category_url(invalid_attributes) }.to change(Category, :count).by(0)
      end
    end

    context 'when user is authorized and params are valid' do
      it 'renders a successful response with authorized user' do
        cat = Category.create(valid_attributes)
        cat.save
        expect { delete category_url(cat) }.to change(Category, :count).by(-1)
      end
    end
  end
end
