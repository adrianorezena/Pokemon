//
//  ListPokemonUseCase.swift
//  DomainLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

protocol ListPokemonUseCaseProtocol {
}
            
final class ListPokemonUseCase: ListPokemonUseCaseProtocol {
    let pokemonRepository: PokemonRepositoryProtocol
    
    init(pokemonRepository: PokemonRepositoryProtocol) {
        self.pokemonRepository = pokemonRepository
    }
    
}
