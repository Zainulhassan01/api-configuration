require 'rails_helper'

describe PokemonController do
  describe 'Get List of Pokemons #index' do
    let(:pokemon_list) {
        JSON.parse(Net::HTTP.get(URI.parse('https://pokeapi.co/api/v2/pokemon?limit=500')))["results"]
    }

    it 'returns the json response of 500 pokemons' do
        expect(pokemon_list.size).to eq 500
      end
    end

    let(:empty_pokemon_list) {
        JSON.parse(Net::HTTP.get(URI.parse('https://pokeapi.co/api/v2/pokemon?limit=500')))[""]
    }

    it 'returns the empty array if no response was found' do
        expect(empty_pokemon_list).to be nil
    end

    describe 'Show page of Pokemon' do
        let(:params) do 
            { 
                id: 1
            }
        end

        it 'returns a specific pokemon' do
            expect(JSON.parse(Net::HTTP.get(URI.parse("https://pokeapi.co/api/v2/pokemon/#{params[:id]}")))["forms"].size).to eq 1
        end

        let(:empty_pokemon){
            JSON.parse(Net::HTTP.get(URI.parse("https://pokeapi.co/api/v2/pokemon/0")))
        }

        it 'returns the empty array if no pokemon was found' do
            expect(empty_pokemon_list).to be nil
        end
    end

    describe 'Search a Pokemon based on name' do
        let(:params) do 
            { 
                name: "bulbasaur"
            }
        end
        
        let(:pokemon_list) {
            JSON.parse(Net::HTTP.get(URI.parse('https://pokeapi.co/api/v2/pokemon?limit=500')))["results"]
        }

        it 'returns a specific pokemon based on search name' do
            pokemon = pokemon_list.select{|pokemon| pokemon["name"].include?(params[:name])}
            expect(pokemon.size).to eq 1
        end

        let(:wrong_params) do 
            {
                name: "sample"
            }
        end

        it 'returns the empty array if no pokemon was found' do
            pokemon = pokemon_list.select{|pokemon| pokemon["name"].include?(wrong_params[:name])}
            expect(pokemon).to eq([])
        end    
    end
end
