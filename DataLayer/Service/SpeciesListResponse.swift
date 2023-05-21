//
//  SpeciesList.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import DomainLayer
import Foundation

public struct SpeciesListResponse: Codable, Equatable {
    public struct SpeciesResponse: Codable, Equatable {
        let name: String
        let url: String
    }
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [SpeciesResponse]
}

extension SpeciesListResponse {
    func toSpeciesList() -> SpeciesList {
        var nextLimit: Int?
        var nextOffset: Int?
        
        if let next: String = next, let pagination = getLimitOffset(next) {
            nextLimit = pagination.limit
            nextOffset = pagination.offset
        }
        
        return SpeciesList(
            count: count,
            nextLimit: nextLimit,
            nextOffset: nextOffset,
            results: results.enumerated().map { index, element in
                return element.toSpecies(id: String(index + 1))
            }
        )
    }
    
    private func getLimitOffset(_ urlString: String) -> (limit: Int, offset: Int)? {
        guard
            let url = URL(string: urlString),
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return nil
        }

        // TODO: move this logic to the object mapping and return as a new property
        let limit = Int(queryItems.first(where: { $0.name == "limit" })?.value ?? "0") ?? 0
        let offset = Int(queryItems.first(where: { $0.name == "offset" })?.value ?? "0") ?? 0
        
        return (limit, offset)
    }
}

extension SpeciesListResponse.SpeciesResponse {
    public func toSpecies(id: String? = nil) -> SpeciesList.Species {
        let id: String = NSString(string: url).lastPathComponent
        let imageURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        
        return SpeciesList.Species(
            name: name,
            id: id,
            imageURL: imageURL
        )
    }
}



