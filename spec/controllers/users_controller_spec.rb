# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'assigns the current user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'assigns the current user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the user' do
        patch :update, params: { id: user.id, user: { first_name: 'NewName' } }
        user.reload
        expect(user.first_name).to eq('NewName')
      end

      it 'redirects to the user show page' do
        patch :update, params: { id: user.id, user: { first_name: 'NewName' } }
        expect(response).to redirect_to(user_path(user))
      end

      it 'sets a success flash message' do
        patch :update, params: { id: user.id, user: { first_name: 'NewName' } }
        expect(flash[:success]).to eq('Votre profil a bien été modifié')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user' do
        patch :update, params: { id: user.id, user: { first_name: nil } }
        user.reload
        expect(user.first_name).not_to be_nil
      end

      it 'renders the show template again' do
        patch :update, params: { id: user.id, user: { first_name: nil } }
        expect(response).to render_template(:show) # Attendez le rendu de la vue show
      end
    end
  end
end
