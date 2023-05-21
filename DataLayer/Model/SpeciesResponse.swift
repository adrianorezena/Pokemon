//
//  SpeciesResponse.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import DomainLayer
import Foundation

public struct SpeciesResponse: Codable, Equatable {
    public let name: String
    public let url: String
}

extension SpeciesResponse {
    public func toSpecies() -> Species {
        let id: String = NSString(string: url).lastPathComponent
        let imageURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        
        return Species(
            name: name,
            id: id,
            imageURL: imageURL
        )
    }
}
