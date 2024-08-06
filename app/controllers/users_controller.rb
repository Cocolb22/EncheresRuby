# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user, only: [:show, :edit, :update]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:message] = 'Votre profil a bien été modifié'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :pseudo, :email, :phone, :street, :zip_code, :city)
  end
end
