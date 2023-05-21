//
//  ChainResponse.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

public struct ChainResponse: Codable, Equatable {
    public let evolutionDetails: [EvolutionDetailResponse]
    public let evolvesTo: [ChainResponse]
    public let isBaby: Bool
    public let species: SpeciesResponse
    
    public init(evolutionDetails: [EvolutionDetailResponse], evolvesTo: [ChainResponse], isBaby: Bool, species: SpeciesResponse) {
        self.evolutionDetails = evolutionDetails
        self.evolvesTo = evolvesTo
        self.isBaby = isBaby
        self.species = species
    }

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}
