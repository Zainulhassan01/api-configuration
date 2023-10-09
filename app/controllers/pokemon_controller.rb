# frozen_string_literal: true

require 'net/http'

class PokemonController < ApplicationController
  API_URL = 'https://pokeapi.co/api/v2/pokemon'

  before_action :pokeman_list, only: %i[index search]

  def index
    render json: @pokemon_lists, status: :ok
  end

  def create
    pokemon = parmas[:pokemon]
    render json: pokemon, status: :created
  end

  def show
    pokemon = JSON.parse(Net::HTTP.get(URI.parse("#{API_URL}/#{params[:id]}")))
    render json: pokemon, status: :ok
  end

  def search
    pokemon = @pokemon_lists.select { |p| p['name'].include?(params[:name]) }
    render json: pokemon, status: :ok
  end

  private

  def pokeman_list
    limit = params[:limit] || '500'
    @pokemon_lists = JSON.parse(Net::HTTP.get(URI.parse("#{API_URL}?limit=#{limit}")))['results']
  end
end
