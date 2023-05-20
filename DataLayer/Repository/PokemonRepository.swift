//
//  PokemonRepository.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

final class PokemonRepository: PokemonServiceProtocol {
    let pokemonService: PokemonServiceProtocol
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesListResponse, Error> {
        return await pokemonService.getSpeciesList(limit: limit, offset: offset)
    }
    
}
