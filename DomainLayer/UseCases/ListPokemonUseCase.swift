//
//  ListPokemonUseCase.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

public protocol ListPokemonUseCaseProtocol {
    func fetchSpecies(limit: Int, offset: Int) async -> Result<[SpeciesList.Species], Error>
}
            
public final class ListPokemonUseCase: ListPokemonUseCaseProtocol {
    let pokemonRepository: PokemonRepositoryProtocol
    
    public init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
    public func fetchSpecies(limit: Int, offset: Int) async -> Result<[SpeciesList.Species], Error> {
        let response = await pokemonRepository.getSpeciesList(limit: limit, offset: offset)
        
        switch response {
        case .success(let speciesList):
            return .success(speciesList.results)
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
}
