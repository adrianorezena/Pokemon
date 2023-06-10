//
//  EvolutionChainResponse.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import DomainLayer
import Foundation

public struct EvolutionChainResponse: Codable, Equatable {
    let url: String
}

public struct ColorResponse: Codable, Equatable {
    let name: String
    let url: String
}

public struct SpeciesDetailResponse: Codable, Equatable {
    let color: ColorResponse
    let evolutionChain: EvolutionChainResponse

    enum CodingKeys: String, CodingKey {
        case color
        case evolutionChain = "evolution_chain"
    }
}

extension SpeciesDetailResponse {
    public func toSpeciesDetail() -> SpeciesDetail {
        let chainID = NSString(string: self.evolutionChain.url).lastPathComponent
        
        return SpeciesDetail(
            chainID: chainID,
            color: color.name)
    }
}
