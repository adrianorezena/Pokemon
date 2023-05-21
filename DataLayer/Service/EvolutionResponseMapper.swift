//
//  EvolutionResponseMapper.swift
//  DataLayer
//
//  Created by Adriano Rezena on 21/05/23.
//

import Foundation

struct EvolutionResponseMapper {
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data) throws -> EvolutionResponse {
        let decoder: JSONDecoder = JSONDecoder()

        guard let speciesList = try? decoder.decode(EvolutionResponse.self, from: data) else {
            throw Error.invalidData
        }
        
        return speciesList
    }

}
