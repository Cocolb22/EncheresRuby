# frozen_string_literal: true

# spec/controllers/articles_controller_spec.rb
require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user:) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new Article to @article' do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end

    it 'fetches the Pokémon list' do
      get :new
      expect(assigns(:pokemons)).not_to be_nil
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new article' do
        expect do
          post :create, params: { article: attributes_for(:article) }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { article: attributes_for(:article) }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new article' do
        expect do
          post :create, params: { article: attributes_for(:article, name: nil) }
        end.to_not change(Article, :count)
      end

      it 're-renders the new template' do
        post :create, params: { article: attributes_for(:article, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested article to @article' do
      get :edit, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end

    it 'fetches the Pokémon list' do
      get :edit, params: { id: article.id }
      expect(assigns(:pokemons)).not_to be_nil
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the article' do
        patch :update, params: { id: article.id, article: { name: 'Updated Name' } }
        article.reload
        expect(article.name).to eq('Updated Name')
      end

      it 'redirects to the article show page' do
        patch :update, params: { id: article.id, article: { name: 'Updated Name' } }
        expect(response).to redirect_to(article_path(article))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the article' do
        patch :update, params: { id: article.id, article: { name: nil } }
        article.reload
        expect(article.name).to_not be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: article.id, article: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the article' do
      article
      expect do
        delete :destroy, params: { id: article.id }
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
