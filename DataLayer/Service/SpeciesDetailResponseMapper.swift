//
//  SpeciesDetailResponseMapper.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

struct SpeciesDetailResponseMapper {
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data) throws -> SpeciesDetailResponse {
        let decoder: JSONDecoder = JSONDecoder()

        guard let speciesList = try? decoder.decode(SpeciesDetailResponse.self, from: data) else {
            throw Error.invalidData
        }
        
        return speciesList
    }

}
