//
//  EvolutionPokemonUseCase.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public protocol EvolutionPokemonUseCaseProtocol {
    func fetchEvolution(id: String) async -> Result<[Species], Error>
}

public final class EvolutionPokemonUseCase: EvolutionPokemonUseCaseProtocol {
    let pokemonRepository: PokemonRepositoryProtocol
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func fetchEvolution(id: String) async -> Result<[Species], Error> {
        let response = await pokemonRepository.fetchEvolution(id: id)
        
        switch response {
        case .success(let species):
            return .success(species)
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
}
