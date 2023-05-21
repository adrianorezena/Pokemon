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
    
    public func fetchEvolution(id: String) async -> Result<[Species], Error> {
        let response = await pokemonService.fetchEvolution(id: id)
        
        switch response {
        case .success(let species):
            var speciesArray: [SpeciesResponse] = []
            speciesArray.append(species.chain.species)
            speciesArray.append(contentsOf: extractEvolution(from: species.chain.evolvesTo))
            
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
    
    // MARK: - Helper
    private func extractEvolution(from objects: [ChainResponse]) -> [SpeciesResponse] {
        var extractedObjects: [SpeciesResponse] = []
        
        for object in objects {
            extractedObjects.append(object.species)
            extractedObjects += extractEvolution(from: object.evolvesTo)
        }
        
        return extractedObjects
    }

}
