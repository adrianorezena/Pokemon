//
//  PokemonRepository.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import DomainLayer
import Foundation

public final class PokemonRepository: PokemonRepositoryProtocol {
    let pokemonService: PokemonServiceProtocol
    
    public init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    public func getSpeciesList(limit: Int, offset: Int) async -> Result<SpeciesList, Error> {
        let response = await pokemonService.getSpeciesList(limit: limit, offset: offset)
        
        switch response {
        case .success(let speciesResponse):
            return .success(speciesResponse.toSpeciesList())
            
        case .failure(let failure):
            return .failure(failure)
        }
    }

}
