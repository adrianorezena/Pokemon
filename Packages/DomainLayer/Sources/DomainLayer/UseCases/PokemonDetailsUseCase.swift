//
//  PokemonDetailsUseCase.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public protocol PokemonDetailsUseCaseProtocol {
    func getSpeciesDetail(id: String) async -> Result<SpeciesDetail, Error>
}

public final class PokemonDetailsUseCase: PokemonDetailsUseCaseProtocol {
    let pokemonRepository: PokemonRepositoryProtocol
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func getSpeciesDetail(id: String) async -> Result<SpeciesDetail, Error> {
        let response = await pokemonRepository.getSpeciesDetail(id: id)
        return response
    }
    
    
}
