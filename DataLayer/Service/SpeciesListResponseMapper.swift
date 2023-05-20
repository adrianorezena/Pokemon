//
//  SpeciesListMapper.swift
//  DataLayer
//
//  Created by Adriano Rezena on 20/05/23.
//

import Foundation

struct SpeciesListResponseMapper {
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data) throws -> SpeciesListResponse {
        let decoder: JSONDecoder = JSONDecoder()

        guard let speciesList = try? decoder.decode(SpeciesListResponse.self, from: data) else {
            throw Error.invalidData
        }
        
        return speciesList
    }

}
