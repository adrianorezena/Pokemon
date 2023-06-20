//
//  File.swift
//  
//
//  Created by Adriano Rezena on 18/06/23.
//

import Foundation

public protocol PokemonFavoriteUseCaseProtocol {
    func addFavorite(species: Species) async throws
    func removeFavorite(species: Species) async throws
    func getFavorites() async -> Result<[Species], Error>
}

public final class PokemonFavoriteUseCase: PokemonFavoriteUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func addFavorite(species: Species) async throws {
        try await repository.addFavorite(species: species)
    }
    
    public func removeFavorite(species: Species) async throws {
        try await repository.removeFavorite(species: species)
    }
    
    public func getFavorites() async -> Result<[Species], Error> {
        await repository.getFavorites()
    }
    
}
