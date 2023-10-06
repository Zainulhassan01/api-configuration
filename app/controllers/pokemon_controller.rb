require 'net/http'

class PokemonController < ActionController::Base
    before_action :set_response, only: [:index, :search]

    def index
        render json: pokemon_lists, status: 200
    end

    def create
        pokemon = parmas[:pokemon]
        render json: pokemon, status: 201
    end

    def show
        pokemon = JSON.parse(Net::HTTP.get(URI.parse(`https://pokeapi.co/api/v2/pokemon/#{params[:id]}`)))
        render json: pokemon, status: 200
    end

    def search
        pokemon = pokemon_lists.select{|pokemon| pokemon["name"].include?(params[:name])}
        render json: pokemon, status: 200
    end

    private

    def set_response
        pokemon_lists = JSON.parse(Net::HTTP.get(URI.parse('https://pokeapi.co/api/v2/pokemon?limit=500')))["results"]
    end
end
