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
        let speciesDetail = await pokemonRepository.getSpeciesDetail(id: id)
        
        switch speciesDetail {
        case .success(let details):
            let evolutionDetails = await pokemonRepository.fetchEvolution(id: details.chainID)
            
            switch evolutionDetails {
            case .success(let species):
                return .success(species)
                
            case .failure(let failure):
                return .failure(failure)
            }
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
}
