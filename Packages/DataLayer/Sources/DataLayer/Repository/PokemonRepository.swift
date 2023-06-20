//
//  PokemonRepository.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import CoreData
import DomainLayer
import Foundation

public final class PokemonRepository: PokemonRepositoryProtocol {
    let pokemonService: PokemonServiceProtocol
    let speciesStore: SpeciesStore?

    public init(
        pokemonService: PokemonServiceProtocol = PokemonService(),
        speciesStore: SpeciesStore?
    ) {
        self.pokemonService = pokemonService
        self.speciesStore = speciesStore
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
    
    public func fetchEvolution(id: String) async -> Result<[Species], Error> {
        let response = await pokemonService.fetchEvolution(id: id)
        
        switch response {
        case .success(let species):
            var speciesArray: [SpeciesResponse] = []
            speciesArray.append(species.chain.species)
            speciesArray.append(contentsOf: extractBaseEvolution(from: species.chain.evolvesTo))
            
            return .success(speciesArray.map { $0.toSpecies() })

        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    public func getSpeciesDetail(id: String) async -> Result<SpeciesDetail, Error> {
        let response = await pokemonService.getSpecies(id: id)
        
        switch response {
        case .success(let speciesDetailResponse):
            return .success(speciesDetailResponse.toSpeciesDetail())
            
        case .failure(let failure):
            return .failure(failure)
        }
    }

}

// MARK: - Helper
extension PokemonRepository {
    
    private func extractBaseEvolution(from objects: [ChainResponse]) -> [SpeciesResponse] {
        var extractedObjects: [SpeciesResponse] = []
        
        if let object = objects.first {
            extractedObjects.append(object.species)
            extractedObjects += object.evolvesTo.map { $0.species }
        }
        
        return extractedObjects
    }
    
}
