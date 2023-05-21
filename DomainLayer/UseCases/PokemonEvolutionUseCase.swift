//
//  EvolutionPokemonUseCase.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public protocol PokemonEvolutionUseCaseProtocol {
    func fetchEvolution(id: String) async -> Result<[Species], Error>
}

public final class PokemonEvolutionUseCase: PokemonEvolutionUseCaseProtocol {
    let pokemonRepository: PokemonRepositoryProtocol
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func fetchEvolution(id: String) async -> Result<[Species], Error> {
        let response = await pokemonRepository.fetchEvolution(id: id)
        return response
    }
    
}
