# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    authorize :admin, :index?
    @users = User.all
    @articles = Article.all
    @users = User.order(:name).page(params[:user_page]).per(10)
    @articles = Article.page(params[:article_page]).per(10)
  end

  def show_user
    @user = User.find(params[:id])
    authorize :admin, :show_user?
  end

  def new_user
    @user = User.new
    authorize :admin, :create_user?
  end

  def create_user
    @user = User.new(user_params)
    authorize :admin, :create_user?
    if @user.save
      redirect_to admin_path
      flash[:success] = t('user.created')
    else
      render :admin
    end
  end

  def destroy_user
    @user = User.find(params[:id])
    authorize :admin, :destroy_user?
    @user.destroy
    redirect_to admin_path
    flash[:success] = t('user.deleted')
  end

  def show_article
    @article = Article.find(params[:id])
    authorize :admin, :show_article?
  end

  def destroy_article
    @article = Article.find(params[:id])
    authorize :admin, :destroy_article?
    @article.destroy
    redirect_to admin_path
    flash[:success] = t('article.deleted')
  end

  private

  def authorize_admin
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :pseudo, :email, :phone,
      :street, :zip_code, :city, :role, :password, :password_confirmation
    )
  end
end
