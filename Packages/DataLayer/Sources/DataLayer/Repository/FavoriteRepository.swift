//
//  FavoriteRepository.swift
//
//
//  Created by Adriano Rezena on 18/06/23.
//

import DomainLayer
import Foundation

public final class FavoriteRepository: FavoriteRepositoryProtocol {
    let speciesStore: SpeciesStore
    
    public init(speciesStore: SpeciesStore) {
        self.speciesStore = speciesStore
    }
    
    public func addFavorite(species: Species) async throws {
        try speciesStore.save(species)
    }
    
    public func removeFavorite(species: Species) async throws {
        try speciesStore.delete(species)
    }
    
    public func getFavorites() async -> Result<[Species], Error> {
        do {
            let favorites = try speciesStore.getAll()
            return .success(favorites)
        } catch {
            return .failure(error)
        }
    }
   
}
