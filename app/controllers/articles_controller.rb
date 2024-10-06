# frozen_string_literal: true

require 'open-uri'
require 'uri'

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :fetch_pokemons, only: %i[new edit]

  def new
    @article = Article.new
    fetch_pokemons
  end

  def create
    @article = Article.new(article_params)
    attach_pokemon_image(@article)
    @article.user = current_user
    @article.status = 'Créée'
    if @article.save
      flash[:success] = t('article.created')
      redirect_to root_path
    else
      flash[:danger] = t('article.not_created')
      render :new
    end
  end

  def show
    authorize @article
    @user = current_user
    @article_user = User.find(@article.user_id)
    @bids = @article.bids.order(bid_price: :desc)
    @highest_bid = @article.get_highest_bid
    @bid = Bid.new
    @winner = @article.get_winner
  end

  def edit
    authorize @article
    fetch_pokemons
  end

  def update
    authorize @article
    if @article.start_date.strftime('%d/%m/%Y %H:%M') < (DateTime.now.strftime('%d/%m/%Y %H:%M'))
      redirect_to article_path(@article)
      flash[:danger] = t('article.cant_update_on_going')
    elsif @article.update(article_params)
      redirect_to article_path(@article)
      flash[:success] = t('article.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    if @article.start_date.strftime('%d/%m/%Y %H:%M') < (DateTime.now.strftime('%d/%m/%Y %H:%M'))
      flash[:danger] = t('article.cant_delete_on_going')
      redirect_to article_path(@article)
    else
      @article.destroy
      redirect_to root_path
      flash[:success] = t('article.deleted')
    end
  end

  def withdraw
    @winner = @article.get_winner
    return unless @winner.is_a?(User) && @winner.id != current_user.id

    redirect_to article_path(@article)
    flash[:danger] = t('article.cant_withdraw')
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :description, :first_price, :start_date, :end_date, :category)
  end

  def open_auction
    @articles = Article.all
    @articles.each do |article|
      next unless article.start_date < DateTime.now

      article.status.update('En cours')
      @article.save
      redirect_to article_path(@article)
    end
  end

  def close_auction
    @articles = Article.all
    @articles.each do |article|
      if article.end_date < DateTime.now
        article.status.update('Fermée')
        article.save
      end
    end
  end

  def fetch_pokemons
    @pokemons = PokemonsHelper.fetch_all_pokemons
    @pokemons_names = @pokemons.map { |pokemon| pokemon['name']['fr'] }
    @first_gen_pokemons_names = @pokemons_names[1..151]
    @first_gen_pokemons = @pokemons.select { |pokemon| pokemon['generation'] == 1 }
    @first_gen_pokemons_category = @first_gen_pokemons.flat_map do |pokemon|
      if pokemon['types'].is_a?(Array)
        pokemon['types'].map { |type| type['name'] }
      else
        []
      end
    end.uniq
  end

  def attach_pokemon_image(article)
    pokemon_image_url = PokemonsHelper.fetch_pokemon_image(article.name)

    if pokemon_image_url
      image = URI.open(pokemon_image_url)
      article.image.attach(io: image, filename: "#{article.name.downcase}.png", content_type: 'image/png')
    else
      Rails.logger.warn "Image not found for Pokémon: #{article.name}"
    end
  end
end
